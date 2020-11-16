//! Contains Plain Structs that get sent to/from FFI

use std::{ffi::CString, os::raw};

use crate::shared_ptr::SharedPtr;

#[repr(C)]
#[derive(Debug, Clone)]
pub struct AccountInfo {
    /// Non-reserved part of the balance. There may still be restrictions on
    /// this, but it is the total pool what may in principle be
    /// transferred, reserved and used for tipping.
    ///
    /// This is the only balance that matters in terms of most operations on
    /// tokens. It alone is used to determine the balance when in the
    /// contract execution environment.
    pub free: *const raw::c_char,
    /// Balance which is reserved and may not be used at all.
    ///
    /// This can still get slashed, but gets slashed last of all.
    ///
    /// This balance is a 'reserve' balance that other subsystems use in order
    /// to set aside tokens that are still 'owned' by the account holder,
    /// but which are suspendable.
    pub reserved: *const raw::c_char,
    /// The amount that `free` may not drop below when withdrawing for
    /// *anything except transaction fee payment*.
    pub misc_frozen: *const raw::c_char,
    /// The amount that `free` may not drop below when withdrawing specifically
    /// for transaction fee payment.
    pub fee_frozen: *const raw::c_char,
}

impl AccountInfo {
    pub fn new(
        free: u128,
        reserved: u128,
        misc_frozen: u128,
        fee_frozen: u128,
    ) -> Self {
        Self {
            free: CString::new(free.to_string()).unwrap().into_raw(),
            reserved: CString::new(reserved.to_string()).unwrap().into_raw(),
            misc_frozen: CString::new(misc_frozen.to_string())
                .unwrap()
                .into_raw(),
            fee_frozen: CString::new(fee_frozen.to_string())
                .unwrap()
                .into_raw(),
        }
    }

    /// Convert `Self` into a raw pointer ready to be sent over ffi.
    /// ### Safety
    /// must call `edg_account_info_free` after done with struct.
    pub unsafe fn into_shared_ptr(self) -> SharedPtr<Self> {
        let boxed = Box::new(self);
        let ptr = Box::into_raw(boxed) as _;
        SharedPtr(ptr)
    }
}

/// Free (Drop) `AccountInfo` allocated by Rust.
///
/// ### Safety
/// this assumes that the given pointer is not null.
#[no_mangle]
pub unsafe extern "C" fn edg_account_info_free(ptr: *mut AccountInfo) {
    if !ptr.is_null() {
        let val = Box::from_raw(ptr);
        CString::from_raw(val.free as _);
        CString::from_raw(val.reserved as _);
        CString::from_raw(val.misc_frozen as _);
        CString::from_raw(val.fee_frozen as _);
        drop(val)
    }
}
