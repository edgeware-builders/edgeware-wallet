use std::{ffi, os::raw};
use substrate_subxt::sp_core::{
    crypto::{AccountId32, Ss58AddressFormat, Ss58Codec},
    Pair,
};

mod array;
mod client;
mod crypto;
mod error;
mod macros;
mod models;
mod runtime;
mod shared_ptr;
mod utils;

pub use array::FfiArray;
pub use models::*;

use shared_ptr::SharedPtr;

type RawKeyPair = *const ffi::c_void;
type RawRpcClient = *const ffi::c_void;
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
    let entropy = ffi_array!(entropy);
    let keypair = crypto::KeyPair::init(entropy.to_vec(), password);
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
    let keypair = unwrap_or_null!(crypto::KeyPair::restore(phrase, password));
    let boxed = Box::new(keypair);
    Box::into_raw(boxed) as _
}

/// Backup KeyPair and get a Mnemonic phrase.
///
/// ### Note
/// you should call `edg_string_free` to free this string after you done with
/// it.
///
/// ### Safety
/// this assumes that `keypair` is not null and it is a valid `KeyPair`.
// otherwise, this function will return null.
#[no_mangle]
pub unsafe extern "C" fn edg_keypair_backup(
    keypair: RawKeyPair,
) -> *const raw::c_char {
    let keypair = keypair!(keypair);
    let phrase = keypair.backup();
    let phrase = unwrap_or_null!(ffi::CString::new(phrase));
    phrase.into_raw()
}

/// Get `KeyPair`'s Public Key in ss58 format.
///
/// ### Note
/// you should call `edg_string_free` to free this string after you done with
/// it.
///
/// ### Safety
/// this assumes that `keypair` is not null and it is a valid `KeyPair`.
// otherwise, this function will return null.
#[no_mangle]
pub unsafe extern "C" fn edg_keypair_public(
    keypair: RawKeyPair,
) -> *const raw::c_char {
    let keypair = keypair!(keypair);
    let pk = keypair
        .pair()
        .public()
        .to_ss58check_with_version(Ss58AddressFormat::EdgewareAccount);
    let pk = unwrap_or_null!(ffi::CString::new(pk));
    pk.into_raw()
}

/// Check for a string is in ss58 format.
///
/// ### Safety
/// this assumes that `address` is not null and it is a valid utf8 string`.
// otherwise, this function will return 0 (false).
#[no_mangle]
pub unsafe extern "C" fn edg_check_ss58_format(
    address: *const raw::c_char,
) -> i32 {
    let address = cstr!(address, err = 0);
    match AccountId32::from_ss58check_with_version(address) {
        Ok((_, format)) => (format == Ss58AddressFormat::EdgewareAccount) as _,
        Err(_) => 0,
    }
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
    let keypair = keypair!(keypair, err = 0);
    let arr = ffi_array!(out, err = 0, as_mut);
    let entropy = keypair.entropy();
    unwrap_or!(arr.write(entropy), err = 0);
    1
}

/// Create and Init the RPC Client return 1 (true).
/// the RPC Client pointer is reterned over the port.
///
/// The Pointer is just a number that can be derefrenced to get the data.
/// ### Safety
/// this assumes that `url` is not null and it is a valid utf8 string`.
// otherwise, this function will 0 (false).
#[no_mangle]
pub unsafe extern "C" fn edg_rpc_client_init(
    port: i64,
    url: *const raw::c_char,
) -> i32 {
    let url = cstr!(url, err = 0);
    let isolate = allo_isolate::Isolate::new(port);
    let task = isolate.catch_unwind(async move {
        let c = client::RpcClient::init(url).await?;
        let boxed = Box::new(c);
        let ptr = Box::into_raw(boxed);
        Result::<_, error::Error>::Ok(SharedPtr(ptr as _))
    });
    runtime::spawn(task);
    1
}

/// Query the chain for Account Info return 1 (true).
/// the `AccountInfo` pointer is reterned over the port.
///
/// The Pointer is just a number that can be derefrenced to get the data.
/// ### Safety
/// this assumes that `ss58` is not null and it is a valid utf8 `string`.
// otherwise, this function will 0 (false).
#[no_mangle]
pub unsafe extern "C" fn edg_rpc_client_query_account_info(
    port: i64,
    client: RawRpcClient,
    ss58: *const raw::c_char,
) -> i32 {
    let ss58 = cstr!(ss58, err = 0);
    let client = rpc_client!(client);
    let isolate = allo_isolate::Isolate::new(port);
    let task = isolate.catch_unwind(async move {
        let info = client.query_account_info(ss58).await?;
        Result::<_, error::Error>::Ok(info.into_shared_ptr())
    });
    runtime::spawn(task);
    1
}

/// Transfer `amount` from the provided `KeyPair` to the provided address.
///
/// The Pointer is just a number that can be derefrenced to get the data.
/// ### Safety
/// this assumes that `to_ss58` is not null and it is a valid utf8 `string`.
/// this assumes that `client` is not null and it is a valid RpcClient.
/// this assumes that `keypair` is not null and it is a valid KeyPair.
// otherwise, this function will 0 (false).
#[no_mangle]
pub unsafe extern "C" fn edg_rpc_client_balance_transfer(
    port: i64,
    client: RawRpcClient,
    keypair: RawKeyPair,
    to_ss58: *const raw::c_char,
    amount: *const raw::c_char,
) -> i32 {
    let ss58 = cstr!(to_ss58, err = 0);
    let amout = u128_parse!(amount);
    let keypair = keypair!(keypair, err = 0);
    let client = rpc_client!(client);
    let isolate = allo_isolate::Isolate::new(port);
    let task = isolate.catch_unwind(async move {
        client.balance_transfer(keypair, ss58, amout).await?;
        Result::<_, error::Error>::Ok(true)
    });
    runtime::spawn(task);
    1
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

/// Free(Clean, Drop) the RpcClient.
///
/// ### Safety
/// this assumes that `ptr` is not null ptr
#[no_mangle]
pub unsafe extern "C" fn edg_rpc_client_free(ptr: RawRpcClient) {
    if !ptr.is_null() {
        let client = Box::from_raw(ptr as *mut client::RpcClient);
        drop(client);
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

/// A Hack around to force Xcode on iOS to link our static lib
/// this a noop function, so it dose not make sense to call it yourself.
#[no_mangle]
pub extern "C" fn edg_link_me_please() {}
