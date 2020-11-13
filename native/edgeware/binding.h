#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>


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

/**
 * Backup KeyPair and get a Mnemonic phrase.
 *
 * ### Note
 * you should call `edg_string_free` to free this string after you done with it.
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
 * you should call `edg_string_free` to free this string after you done with it.
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

void edg_link_me_please(void);

/**
 * Free (Drop) a string value allocated by Rust.
 *
 * ### Safety
 * this assumes that the given pointer is not null.
 */
void edg_string_free(const char *ptr);
