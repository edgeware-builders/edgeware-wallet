use allo_isolate::{ffi, IntoDart};

/// A Shared Pointer is used to transfer a Pointer from Rust side to Dart side
/// in a safe way. this however, is not intented to be used outside of DartVM
/// and the caller after getting the ptr and done with it, must call the `free`
/// function
#[repr(C)]
pub struct SharedPtr<T>(pub *const T);

unsafe impl<T> Send for SharedPtr<T> {}

impl<T> IntoDart for SharedPtr<T> {
    fn into_dart(self) -> ffi::DartCObject { self.0.into_dart() }
}
