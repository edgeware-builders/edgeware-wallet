// AUTO GENERATED FILE, DO NOT EDIT.
//
// Generated by `package:ffigen`.
import 'dart:ffi' as ffi;

/// Edgeware Client Binding
class RawEdgeware {
  /// Holds the Dynamic library.
  final ffi.DynamicLibrary _dylib;

  /// The symbols are looked up in [dynamicLibrary].
  RawEdgeware(ffi.DynamicLibrary dynamicLibrary) : _dylib = dynamicLibrary;

  /// Free(Clean, Drop) the KeyPair.
  ///
  /// ### Safety
  /// this assumes that `ptr` is not null ptr
  void edg_keypair_free(
    ffi.Pointer<ffi.Void> ptr,
  ) {
    _edg_keypair_free ??=
        _dylib.lookupFunction<_c_edg_keypair_free, _dart_edg_keypair_free>(
            'edg_keypair_free');
    return _edg_keypair_free(
      ptr,
    );
  }

  _dart_edg_keypair_free _edg_keypair_free;

  /// Init KeyPair using the entropy.
  ///
  /// ### Safety
  /// this assumes that `entropy` is not null and is 16 byte length array.
  /// this assumes that `password` is not null and it is a valid utf8 string.
  ffi.Pointer<ffi.Void> edg_keypair_init(
    ffi.Pointer<FfiArray> entropy,
    ffi.Pointer<ffi.Int8> password,
  ) {
    _edg_keypair_init ??=
        _dylib.lookupFunction<_c_edg_keypair_init, _dart_edg_keypair_init>(
            'edg_keypair_init');
    return _edg_keypair_init(
      entropy,
      password,
    );
  }

  _dart_edg_keypair_init _edg_keypair_init;

  /// Create new KeyPair.
  /// this will generate a new KeyPair locally.
  ///
  /// ### Safety
  /// this assumes that `password` is not null and it is a valid utf8 string.
  ffi.Pointer<ffi.Void> edg_keypair_new(
    ffi.Pointer<ffi.Int8> password,
  ) {
    _edg_keypair_new ??=
        _dylib.lookupFunction<_c_edg_keypair_new, _dart_edg_keypair_new>(
            'edg_keypair_new');
    return _edg_keypair_new(
      password,
    );
  }

  _dart_edg_keypair_new _edg_keypair_new;

  /// Restore KeyPair using Mnemonic phrase.
  ///
  /// ### Safety
  /// this assumes that `phrase` is not null and is 16 byte length array.
  /// this assumes that `password` is not null and it is a valid utf8 string.
  ffi.Pointer<ffi.Void> edg_keypair_restore(
    ffi.Pointer<ffi.Int8> phrase,
    ffi.Pointer<ffi.Int8> password,
  ) {
    _edg_keypair_restore ??= _dylib.lookupFunction<_c_edg_keypair_restore,
        _dart_edg_keypair_restore>('edg_keypair_restore');
    return _edg_keypair_restore(
      phrase,
      password,
    );
  }

  _dart_edg_keypair_restore _edg_keypair_restore;

  void edg_link_me_please() {
    _edg_link_me_please ??=
        _dylib.lookupFunction<_c_edg_link_me_please, _dart_edg_link_me_please>(
            'edg_link_me_please');
    return _edg_link_me_please();
  }

  _dart_edg_link_me_please _edg_link_me_please;

  /// Free (Drop) a string value allocated by Rust.
  ///
  /// ### Safety
  /// this assumes that the given pointer is not null.
  void edg_string_free(
    ffi.Pointer<ffi.Int8> ptr,
  ) {
    _edg_string_free ??=
        _dylib.lookupFunction<_c_edg_string_free, _dart_edg_string_free>(
            'edg_string_free');
    return _edg_string_free(
      ptr,
    );
  }

  _dart_edg_string_free _edg_string_free;
}

/// A Fixed Sized FFI compatable Array (Buffer View)
class FfiArray extends ffi.Struct {
  ffi.Pointer<ffi.Uint8> buf;

  @ffi.Uint64()
  int len;
}

typedef _c_edg_keypair_free = ffi.Void Function(
  ffi.Pointer<ffi.Void> ptr,
);

typedef _dart_edg_keypair_free = void Function(
  ffi.Pointer<ffi.Void> ptr,
);

typedef _c_edg_keypair_init = ffi.Pointer<ffi.Void> Function(
  ffi.Pointer<FfiArray> entropy,
  ffi.Pointer<ffi.Int8> password,
);

typedef _dart_edg_keypair_init = ffi.Pointer<ffi.Void> Function(
  ffi.Pointer<FfiArray> entropy,
  ffi.Pointer<ffi.Int8> password,
);

typedef _c_edg_keypair_new = ffi.Pointer<ffi.Void> Function(
  ffi.Pointer<ffi.Int8> password,
);

typedef _dart_edg_keypair_new = ffi.Pointer<ffi.Void> Function(
  ffi.Pointer<ffi.Int8> password,
);

typedef _c_edg_keypair_restore = ffi.Pointer<ffi.Void> Function(
  ffi.Pointer<ffi.Int8> phrase,
  ffi.Pointer<ffi.Int8> password,
);

typedef _dart_edg_keypair_restore = ffi.Pointer<ffi.Void> Function(
  ffi.Pointer<ffi.Int8> phrase,
  ffi.Pointer<ffi.Int8> password,
);

typedef _c_edg_link_me_please = ffi.Void Function();

typedef _dart_edg_link_me_please = void Function();

typedef _c_edg_string_free = ffi.Void Function(
  ffi.Pointer<ffi.Int8> ptr,
);

typedef _dart_edg_string_free = void Function(
  ffi.Pointer<ffi.Int8> ptr,
);
