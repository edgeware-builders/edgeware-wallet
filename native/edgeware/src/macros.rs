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
    ($ptr:expr, err = $error:expr, allow_null) => {
        if $ptr.is_null() {
            None
        } else {
            Some($crate::cstr!($ptr, err = $error))
        }
    };
    ($ptr:expr) => {
        $crate::cstr!($ptr, err = std::ptr::null());
    };
    ($ptr:expr, err = $error:expr) => {{
        if $ptr.is_null() {
            return $error;
        }
        $crate::unwrap_or!(
            ::std::ffi::CStr::from_ptr($ptr).to_str(),
            err = $error
        )
    }};
}

#[doc(hidden)]
#[macro_export]
macro_rules! unwrap_or_null {
    ($result:expr) => {
        $crate::unwrap_or!($result, err = std::ptr::null());
    };
}

#[doc(hidden)]
#[macro_export]
macro_rules! unwrap_or {
    ($result:expr, err = $err:expr) => {
        match $result {
            Ok(value) => value,
            Err(_) => return $err,
        }
    };
}

#[doc(hidden)]
#[macro_export]
macro_rules! keypair {
    ($ptr:expr) => {
        $crate::keypair!($ptr, err = std::ptr::null());
    };

    ($ptr:expr, err = $err:expr) => {
        match $ptr.cast::<crate::crypto::KeyPair>().as_ref() {
            Some(v) => v,
            None => return $err,
        }
    };
}

#[doc(hidden)]
#[macro_export]
macro_rules! ffi_array {
    ($ptr:expr) => {
        $crate::ffi_array!($ptr, err = std::ptr::null());
    };

    ($ptr:expr, as_mut) => {
        $crate::ffi_array!($ptr, err = std::ptr::null(), as_mut);
    };

    ($ptr:expr, err = $err:expr) => {
        match $ptr.as_ref() {
            Some(v) => v,
            None => return $err,
        }
    };

    ($ptr:expr, err = $err:expr, as_mut) => {
        match $ptr.as_mut() {
            Some(v) => v,
            None => return $err,
        }
    };
}

#[doc(hidden)]
#[macro_export]
macro_rules! rpc_client {
    ($ptr:expr) => {
        $crate::rpc_client!($ptr, err = 0);
    };

    ($ptr:expr, err = $err:expr) => {
        match $ptr.cast::<crate::client::RpcClient>().as_ref() {
            Some(v) => v,
            None => return $err,
        }
    };
}

#[doc(hidden)]
#[macro_export]
macro_rules! u128_parse {
    ($ptr:expr) => {
        $crate::u128_parse!($ptr, err = 0);
    };
    ($ptr:expr, err = $err:expr) => {{
        let s = $crate::cstr!($ptr, err = $err);
        match s.parse::<u128>() {
            Ok(val) => val,
            Err(_) => return $err,
        }
    }};
}
