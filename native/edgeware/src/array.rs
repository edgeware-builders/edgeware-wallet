use std::ptr::NonNull;

/// A Fixed Sized FFI compatable Array (Buffer View)
#[repr(C)]
pub struct FfiArray {
    buf: NonNull<u8>,
    len: usize,
}

impl AsRef<[u8]> for FfiArray {
    fn as_ref(&self) -> &[u8] {
        unsafe { std::slice::from_raw_parts(self.buf.as_ptr(), self.len) }
    }
}

impl AsMut<[u8]> for FfiArray {
    fn as_mut(&mut self) -> &mut [u8] {
        unsafe { std::slice::from_raw_parts_mut(self.buf.as_ptr(), self.len) }
    }
}

impl FfiArray {
    /// Copies all elements from `bytes` into our buffer, using a memcpy.
    /// The length of `bytes` must be the same as our buffer length.
    /// otherwise, it will return Error.
    pub fn write(&mut self, bytes: &[u8]) -> Result<(), ()> {
        if self.len() == bytes.len() {
            self.as_mut().copy_from_slice(bytes);
            Ok(())
        } else {
            Err(())
        }
    }

    pub fn to_vec(&self) -> Vec<u8> { self.as_ref().to_vec() }

    pub fn len(&self) -> usize { self.len }

    pub fn is_empty(&self) -> bool { self.len == 0 }
}
