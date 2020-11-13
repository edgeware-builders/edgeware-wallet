use std::{ffi, os::raw};
use substrate_subxt::sp_core::{crypto::Ss58Codec, Pair};

mod array;
mod crypto;
mod error;
mod macros;

pub use array::FfiArray;

type RawKeyPair = *const ffi::c_void;
type RawFfiArray = *const FfiArray;
type RawMutFfiArray = *mut FfiArray;

/// Create new KeyPair.
/// this will generate a new KeyPair locally.
///
/// ### Safety
/// this assumes that `password` is not null and it is a valid utf8 string.
// otherwise, this function will return null.
#[no_mangle]
pub unsafe extern "C" fn edg_keypair_new(
    password: *const raw::c_char,
) -> RawKeyPair {
    let password = cstr!(password);
    let keypair = crypto::KeyPair::new(Default::default(), password);
    let boxed = Box::new(keypair);
    Box::into_raw(boxed) as _
}

/// Init KeyPair using the entropy.
///
/// ### Safety
/// this assumes that `entropy` is not null and is 16 byte length array.
/// this assumes that `password` is not null and it is a valid utf8 string.
// otherwise, this function will return null.
#[no_mangle]
pub unsafe extern "C" fn edg_keypair_init(
    entropy: RawFfiArray,
    password: *const raw::c_char,
) -> RawKeyPair {
    let password = cstr!(password);
    let entropy = match entropy.as_ref() {
        Some(e) => e,
        None => return std::ptr::null(),
    };
    let keypair = crypto::KeyPair::init(entropy.as_ref().to_owned(), password);
    let boxed = Box::new(keypair);
    Box::into_raw(boxed) as _
}

/// Restore KeyPair using Mnemonic phrase.
///
/// ### Safety
/// this assumes that `phrase` is not null and is 16 byte length array.
/// this assumes that `password` is not null and it is a valid utf8 string.
// otherwise, this function will return null.
#[no_mangle]
pub unsafe extern "C" fn edg_keypair_restore(
    phrase: *const raw::c_char,
    password: *const raw::c_char,
) -> RawKeyPair {
    let phrase = cstr!(phrase);
    let password = cstr!(password);
    let keypair = match crypto::KeyPair::restore(phrase, password) {
        Ok(v) => v,
        Err(_) => return std::ptr::null(),
    };
    let boxed = Box::new(keypair);
    Box::into_raw(boxed) as _
}

/// Backup KeyPair and get a Mnemonic phrase.
///
/// ### Note
/// you should call `edg_string_free` to free this string after you done with it.
///
/// ### Safety
/// this assumes that `keypair` is not null and it is a valid `KeyPair`.
// otherwise, this function will return null.
#[no_mangle]
pub unsafe extern "C" fn edg_keypair_backup(
    keypair: RawKeyPair,
) -> *const raw::c_char {
    let keypair = match keypair.cast::<crypto::KeyPair>().as_ref() {
        Some(v) => v,
        None => return std::ptr::null(),
    };
    let pharse = keypair.backup();
    let pharse = ffi::CString::new(pharse).expect("valid string");
    pharse.into_raw()
}

/// Get `KeyPair`'s Public Key in ss58 format.
///
/// ### Note
/// you should call `edg_string_free` to free this string after you done with it.
///
/// ### Safety
/// this assumes that `keypair` is not null and it is a valid `KeyPair`.
// otherwise, this function will return null.
#[no_mangle]
pub unsafe extern "C" fn edg_keypair_public(
    keypair: RawKeyPair,
) -> *const raw::c_char {
    let keypair = match keypair.cast::<crypto::KeyPair>().as_ref() {
        Some(v) => v,
        None => return std::ptr::null(),
    };
    let pk = keypair.pair().public().to_ss58check();
    let pk = ffi::CString::new(pk).expect("valid string");
    pk.into_raw()
}

/// Get `KeyPair`'s Entropy and return 1 (true).
/// the `out` array length must be equal to the `KeyPair`s entropy length.
///
/// + 16 bytes for 12 words.
/// + 20 bytes for 15 words.
/// + 24 bytes for 18 words.
/// + 28 bytes for 21 words.
/// + 32 bytes for 24 words.
///
/// Any other length will return an error 0 (false).
/// ### Safety
/// this assumes that `keypair` is not null and it is a valid `KeyPair`.
// otherwise, this function will 0 (false).
#[no_mangle]
pub unsafe extern "C" fn edg_keypair_entropy(
    keypair: RawKeyPair,
    out: RawMutFfiArray,
) -> i32 {
    let keypair = match keypair.cast::<crypto::KeyPair>().as_ref() {
        Some(v) => v,
        None => return 0,
    };
    let arr = match out.as_mut() {
        Some(v) => v,
        None => return 0,
    };
    let entropy = keypair.entropy();
    match arr.write(entropy) {
        Ok(_) => 1,
        Err(_) => 0,
    }
}

/// Free(Clean, Drop) the KeyPair.
///
/// ### Safety
/// this assumes that `ptr` is not null ptr
#[no_mangle]
pub unsafe extern "C" fn edg_keypair_free(ptr: RawKeyPair) {
    if !ptr.is_null() {
        let pair = Box::from_raw(ptr as *mut crypto::KeyPair);
        pair.clean();
    }
}

/// Free (Drop) a string value allocated by Rust.
///
/// ### Safety
/// this assumes that the given pointer is not null.
#[no_mangle]
pub unsafe extern "C" fn edg_string_free(ptr: *const raw::c_char) {
    if !ptr.is_null() {
        let cstring = ffi::CString::from_raw(ptr as _);
        drop(cstring)
    }
}

#[no_mangle]
pub extern "C" fn edg_link_me_please() {}
