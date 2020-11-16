#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>


typedef struct AccountInfo {
  /**
   * Non-reserved part of the balance. There may still be restrictions on
   * this, but it is the total pool what may in principle be
   * transferred, reserved and used for tipping.
   *
   * This is the only balance that matters in terms of most operations on
   * tokens. It alone is used to determine the balance when in the
   * contract execution environment.
   */
  const char *free;
  /**
   * Balance which is reserved and may not be used at all.
   *
   * This can still get slashed, but gets slashed last of all.
   *
   * This balance is a 'reserve' balance that other subsystems use in order
   * to set aside tokens that are still 'owned' by the account holder,
   * but which are suspendable.
   */
  const char *reserved;
  /**
   * The amount that `free` may not drop below when withdrawing for
   * *anything except transaction fee payment*.
   */
  const char *misc_frozen;
  /**
   * The amount that `free` may not drop below when withdrawing specifically
   * for transaction fee payment.
   */
  const char *fee_frozen;
} AccountInfo;

typedef const void *RawKeyPair;

/**
 * A Fixed Sized FFI compatable Array (Buffer View)
 */
typedef struct FfiArray {
  uint8_t *buf;
  uintptr_t len;
} FfiArray;

typedef FfiArray *RawMutFfiArray;

typedef const FfiArray *RawFfiArray;

typedef const void *RawRpcClient;

/**
 * Free (Drop) `AccountInfo` allocated by Rust.
 *
 * ### Safety
 * this assumes that the given pointer is not null.
 */
void edg_account_info_free(AccountInfo *ptr);

/**
 * Backup KeyPair and get a Mnemonic phrase.
 *
 * ### Note
 * you should call `edg_string_free` to free this string after you done with
 * it.
 *
 * ### Safety
 * this assumes that `keypair` is not null and it is a valid `KeyPair`.
 */
const char *edg_keypair_backup(RawKeyPair keypair);

/**
 * Get `KeyPair`'s Entropy and return 1 (true).
 * the `out` array length must be equal to the `KeyPair`s entropy length.
 *
 * + 16 bytes for 12 words.
 * + 20 bytes for 15 words.
 * + 24 bytes for 18 words.
 * + 28 bytes for 21 words.
 * + 32 bytes for 24 words.
 *
 * Any other length will return an error 0 (false).
 * ### Safety
 * this assumes that `keypair` is not null and it is a valid `KeyPair`.
 */
int32_t edg_keypair_entropy(RawKeyPair keypair, RawMutFfiArray out);

/**
 * Free(Clean, Drop) the KeyPair.
 *
 * ### Safety
 * this assumes that `ptr` is not null ptr
 */
void edg_keypair_free(RawKeyPair ptr);

/**
 * Init KeyPair using the entropy.
 *
 * ### Safety
 * this assumes that `entropy` is not null and is 16 byte length array.
 * this assumes that `password` is not null and it is a valid utf8 string.
 */
RawKeyPair edg_keypair_init(RawFfiArray entropy, const char *password);

/**
 * Create new KeyPair.
 * this will generate a new KeyPair locally.
 *
 * ### Safety
 * this assumes that `password` is not null and it is a valid utf8 string.
 */
RawKeyPair edg_keypair_new(const char *password);

/**
 * Get `KeyPair`'s Public Key in ss58 format.
 *
 * ### Note
 * you should call `edg_string_free` to free this string after you done with
 * it.
 *
 * ### Safety
 * this assumes that `keypair` is not null and it is a valid `KeyPair`.
 */
const char *edg_keypair_public(RawKeyPair keypair);

/**
 * Restore KeyPair using Mnemonic phrase.
 *
 * ### Safety
 * this assumes that `phrase` is not null and is 16 byte length array.
 * this assumes that `password` is not null and it is a valid utf8 string.
 */
RawKeyPair edg_keypair_restore(const char *phrase, const char *password);

/**
 * A Hack around to force Xcode on iOS to link our static lib
 * this a noop function, so it dose not make sense to call it yourself.
 */
void edg_link_me_please(void);

/**
 * Transfer `amount` from the provided `KeyPair` to the provided address.
 *
 * The Pointer is just a number that can be derefrenced to get the data.
 * ### Safety
 * this assumes that `to_ss58` is not null and it is a valid utf8 `string`.
 * this assumes that `client` is not null and it is a valid RpcClient.
 * this assumes that `keypair` is not null and it is a valid KeyPair.
 */
int32_t edg_rpc_client_balance_transfer(int64_t port,
                                        RawRpcClient client,
                                        RawKeyPair keypair,
                                        const char *to_ss58,
                                        const char *amount);

/**
 * Free(Clean, Drop) the RpcClient.
 *
 * ### Safety
 * this assumes that `ptr` is not null ptr
 */
void edg_rpc_client_free(RawRpcClient ptr);

/**
 * Create and Init the RPC Client return 1 (true).
 * the RPC Client pointer is reterned over the port.
 *
 * The Pointer is just a number that can be derefrenced to get the data.
 * ### Safety
 * this assumes that `url` is not null and it is a valid utf8 string`.
 */
int32_t edg_rpc_client_init(int64_t port, const char *url);

/**
 * Query the chain for Account Info return 1 (true).
 * the `AccountInfo` pointer is reterned over the port.
 *
 * The Pointer is just a number that can be derefrenced to get the data.
 * ### Safety
 * this assumes that `ss58` is not null and it is a valid utf8 `string`.
 */
int32_t edg_rpc_client_query_account_info(int64_t port, RawRpcClient client, const char *ss58);

/**
 * Free (Drop) a string value allocated by Rust.
 *
 * ### Safety
 * this assumes that the given pointer is not null.
 */
void edg_string_free(const char *ptr);
