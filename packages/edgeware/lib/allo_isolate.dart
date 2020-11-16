import 'dart:ffi';

/// `allo-isolate` Rust crate bindings.
class AlloIsolate {
  AlloIsolate(this.lib);
  final DynamicLibrary lib;

  void hook() {
    _store_dart_post_cobject ??= lib.lookupFunction<_store_dart_post_cobject_C,
        _store_dart_post_cobject_Dart>('store_dart_post_cobject');
    _store_dart_post_cobject(NativeApi.postCObject);
  }

  // ignore: non_constant_identifier_names
  _store_dart_post_cobject_Dart _store_dart_post_cobject;
}

// ignore: avoid_private_typedef_functions
typedef _store_dart_post_cobject_C = Void Function(
  Pointer<NativeFunction<Int8 Function(Int64, Pointer<Dart_CObject>)>> ptr,
);

typedef _store_dart_post_cobject_Dart = void Function(
  Pointer<NativeFunction<Int8 Function(Int64, Pointer<Dart_CObject>)>> ptr,
);
