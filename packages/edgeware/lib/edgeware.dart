library edgeware;

import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:isolate/isolate.dart';
import 'package:meta/meta.dart';

import 'allo_isolate.dart';
import 'extensions.dart';
import 'ffi.dart' as ffi;
import 'models/models.dart';

export 'models/models.dart';

/// Edgeware Rust Binding.
/// this a high level abstraction over the FFI
class Edgeware {
  Edgeware() : _dl = _load() {
    _lib ??= ffi.RawEdgeware(_dl);
    AlloIsolate(_dl).hook();
  }
  final DynamicLibrary _dl;
  ffi.RawEdgeware _lib;
  Pointer<Void> _keypair = nullptr;
  Pointer<Void> _rpc = nullptr;

  KeyPair generateKeyPair(String password) {
    _keypair = _lib.edg_keypair_new(password.toPointer().cast());
    assert(_keypair != nullptr);
    final entropyOut = Uint8List(16).asFixed16ArrayPtr();
    final result = _lib.edg_keypair_entropy(_keypair, entropyOut);
    assert(result == 1);
    final pkPtr = _lib.edg_keypair_public(_keypair);
    assert(pkPtr != nullptr);
    final pk = Utf8.fromUtf8(pkPtr.cast());
    final entropy = entropyOut.asUint8List();
    return KeyPair._(entropy, pk);
  }

  KeyPair initKeyPair(Uint8List entropy, String password) {
    _keypair = _lib.edg_keypair_init(
      entropy.asFixed16ArrayPtr(),
      password.toPointer().cast(),
    );
    assert(_keypair != nullptr);
    final pkPtr = _lib.edg_keypair_public(_keypair);
    assert(pkPtr != nullptr);
    final pk = Utf8.fromUtf8(pkPtr.cast());
    return KeyPair._(entropy, pk);
  }

  KeyPair restoreKeyPair(String phrase, String password) {
    _keypair = _lib.edg_keypair_restore(
      phrase.toPointer().cast(),
      password.toPointer().cast(),
    );
    if (_keypair == nullptr) {
      throw StateError('invalid seed phrase.');
    }
    final entropyOut = Uint8List(16).asFixed16ArrayPtr();
    final result = _lib.edg_keypair_entropy(_keypair, entropyOut);
    assert(result == 1);
    final pkPtr = _lib.edg_keypair_public(_keypair);
    assert(pkPtr != nullptr);
    final pk = Utf8.fromUtf8(pkPtr.cast());
    final entropy = entropyOut.asUint8List();
    return KeyPair._(entropy, pk);
  }

  String backupKeyPair() {
    assert(_keypair != nullptr);
    final phrasePtr = _lib.edg_keypair_backup(_keypair);
    assert(phrasePtr != nullptr);
    final phrase = Utf8.fromUtf8(phrasePtr.cast());
    _lib.edg_string_free(phrasePtr);
    return phrase;
  }

  void cleanKeyPair() {
    _lib.edg_keypair_free(_keypair);
    _keypair = nullptr;
  }

  Future<void> initRpcClient({@required String url}) async {
    final completer = Completer<dynamic>();
    final port = singleCompletePort(completer);
    final result = _lib.edg_rpc_client_init(
      port.nativePort,
      url.toPointer().cast(),
    );
    assert(result == 1);
    final res = await completer.future;
    if (res is int) {
      _rpc = Pointer.fromAddress(res);
    } else if (res is String) {
      throw StateError(res);
    } else {
      throw StateError('Got unknown type: ${res.runtimeType} $res');
    }
  }

  Future<AccountInfo> queryAccountInfo({@required String ss58}) async {
    final completer = Completer<dynamic>();
    final port = singleCompletePort(completer);
    final result = _lib.edg_rpc_client_query_account_info(
      port.nativePort,
      _rpc,
      ss58.toPointer().cast(),
    );
    assert(result == 1);
    final res = await completer.future;
    if (res is int) {
      final info = Pointer<ffi.AccountInfo>.fromAddress(res);
      final accountInfo = AccountInfo.fromFFI(info.ref);
      _lib.edg_account_info_free(info);
      return accountInfo;
    } else if (res is String) {
      throw StateError(res);
    } else {
      throw StateError('Got unknown type: ${res.runtimeType} $res');
    }
  }

  Future<void> balanceTransfer({
    @required String toSs58,
    @required BigInt amount,
  }) async {
    final completer = Completer<dynamic>();
    final port = singleCompletePort(completer);
    final result = _lib.edg_rpc_client_balance_transfer(
      port.nativePort,
      _rpc,
      _keypair,
      toSs58.toPointer().cast(),
      amount.toString().toPointer().cast(),
    );
    assert(result == 1);
    final res = await completer.future;
    print(res);
    if (res is int) {
      return;
    } else if (res is String) {
      throw StateError(res);
    } else {
      throw StateError('Got unknown type: ${res.runtimeType} $res');
    }
  }
}

class KeyPair {
  const KeyPair._(Uint8List entropy, String pk)
      : _inner = entropy,
        _pk = pk;

  final Uint8List _inner;
  final String _pk;

  /// Get the public key.
  String get public => _pk;

  /// Expose the underlaying entropy bytes.
  Uint8List expose() {
    return _inner;
  }

  @override
  int get hashCode => _inner.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is KeyPair) {
      return _inner == other._inner;
    } else {
      return false;
    }
  }
}

/// Loads the Edgeware [DynamicLibrary] depending on the [Platform]
DynamicLibrary _load() {
  if (Platform.isAndroid) {
    return DynamicLibrary.open('libedgeware.so');
  } else if (Platform.isIOS) {
    return DynamicLibrary.executable();
  } else {
    throw UnsupportedError('The Current Platform is not supported.');
  }
}
