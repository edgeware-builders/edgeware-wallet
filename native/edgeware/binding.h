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

typedef const FfiArray *RawFfiArray;

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
