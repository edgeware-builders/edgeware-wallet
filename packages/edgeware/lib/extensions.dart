import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:ffi/ffi.dart' as ffi;

import 'ffi.dart' as ffi;

extension FixedArray on Uint8List {
  Pointer<ffi.FfiArray> asFixed16ArrayPtr() {
    assert(length == 16);
    final ptr = ffi.allocate<Uint8>(count: 16)..asTypedList(16).setAll(0, this);
    final arr = ffi.allocate<ffi.FfiArray>();
    arr.ref.buf = ptr;
    arr.ref.len = 16;
    return arr;
  }

  Pointer<ffi.FfiArray> asFixed32ArrayPtr() {
    assert(length == 32);
    final ptr = ffi.allocate<Uint8>(count: 32)..asTypedList(32).setAll(0, this);
    final arr = ffi.allocate<ffi.FfiArray>();
    arr.ref.buf = ptr;
    arr.ref.len = 32;
    return arr;
  }
}

extension Uint8ListArray on Pointer<ffi.FfiArray> {
  Uint8List asUint8List() {
    final view = ref.buf.asTypedList(ref.len);
    final builder = BytesBuilder(copy: false)..add(view);
    final bytes = builder.takeBytes();
    ffi.free(this);
    return bytes;
  }
}

extension StringPointer on String {
  Pointer<ffi.Utf8> toPointer() {
    if (this == null) {
      return nullptr;
    }
    return ffi.Utf8.toUtf8(this);
  }
}
