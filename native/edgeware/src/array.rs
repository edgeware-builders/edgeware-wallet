/// A Fixed Sized FFI compatable Array (Buffer View)
#[repr(C)]
pub struct FfiArray {
    buf: *mut u8,
    len: usize,
}

impl AsRef<[u8]> for FfiArray {
    fn as_ref(&self) -> &[u8] {
        unsafe { std::slice::from_raw_parts(self.buf, self.len) }
    }
}

impl AsMut<[u8]> for FfiArray {
    fn as_mut(&mut self) -> &mut [u8] {
        unsafe { std::slice::from_raw_parts_mut(self.buf, self.len) }
    }
}

impl FfiArray {
    /// Copies all elements from `bytes` into our buffer, using a memcpy.
    /// The length of `bytes` must be the same as our buffer length.
    ///
    /// ### Panics
    /// This function will panic if the two slices have different lengths.
    pub fn write(&mut self, bytes: &[u8]) {
        debug_assert!(self.len == bytes.len(), "length mismatch");
        self.as_mut().copy_from_slice(bytes);
    }
}
