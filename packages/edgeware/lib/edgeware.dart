library edgeware;

import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:ffi/ffi.dart';

import 'extensions.dart';
import 'ffi.dart' as ffi;

/// Edgeware Rust Binding.
/// this a high level abstraction over the FFI
class Edgeware {
  Edgeware() : _dl = _load() {
    _lib ??= ffi.RawEdgeware(_dl);
  }
  final DynamicLibrary _dl;
  ffi.RawEdgeware _lib;
  Pointer<Void> _keypair = nullptr;

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
