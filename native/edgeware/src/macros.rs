/// A macro to convert c_char pointer to rust's str type
#[doc(hidden)]
#[macro_export]
macro_rules! cstr {
    ($ptr:expr, allow_null) => {
        if $ptr.is_null() {
            None
        } else {
            Some($crate::cstr!($ptr))
        }
    };
    ($ptr:expr, allow_null, $error:expr) => {
        if $ptr.is_null() {
            None
        } else {
            Some($crate::cstr!($ptr, $error))
        }
    };
    ($ptr:expr) => {
        $crate::cstr!($ptr, std::ptr::null());
    };
    ($ptr:expr, $error:expr) => {{
        if $ptr.is_null() {
            return $error;
        }
        $crate::unwrap_or_null!(
            ::std::ffi::CStr::from_ptr($ptr).to_str(),
            $error
        )
    }};
}

#[doc(hidden)]
#[macro_export]
macro_rules! unwrap_or_null {
    ($result:expr) => {
        $crate::unwrap_or_null!($result, std::ptr::null());
    };

    ($result:expr, $err:expr) => {
        match $result {
            Ok(value) => value,
            Err(_) => return $err,
        }
    };
}
