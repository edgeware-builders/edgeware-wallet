use std::num::NonZeroUsize;

use bip39::{Language, Mnemonic, MnemonicType};
use sp_core::sr25519::Pair;
use substrate_subxt::sp_core;
use zeroize::Zeroize;

use crate::error::Error;

pub struct KeyPair {
    pair: Pair,
    entropy: Vec<u8>,
}

#[derive(Debug, Copy, Clone)]
pub struct KeyPairConfig {
    pub word_count: NonZeroUsize,
}

impl Default for KeyPairConfig {
    fn default() -> Self {
        Self {
            word_count: NonZeroUsize::new(12).unwrap(),
        }
    }
}

impl KeyPair {
    pub fn new(config: KeyPairConfig, password: &str) -> Self {
        let mtype = MnemonicType::for_word_count(config.word_count.into())
            .unwrap_or(MnemonicType::Words12);
        let mnemonic = Mnemonic::new(mtype, Language::English);
        let entropy = mnemonic.entropy();
        let (pair, _) = Pair::from_entropy(entropy, Some(password));
        KeyPair {
            pair,
            entropy: entropy.to_vec(),
        }
    }

    pub fn init(entropy: Vec<u8>, password: &str) -> Self {
        let (pair, _) = Pair::from_entropy(&entropy, Some(password));
        KeyPair {
            pair,
            entropy: entropy.to_vec(),
        }
    }

    pub fn restore(phrase: &str, password: &str) -> Result<Self, Error> {
        let mnemonic = Mnemonic::from_phrase(phrase, Language::English)?;
        let entropy = mnemonic.entropy();
        let (pair, _) = Pair::from_entropy(entropy, Some(password));
        Ok(KeyPair {
            pair,
            entropy: entropy.to_vec(),
        })
    }

    pub fn backup(&self) -> String {
        let mnemonic = Mnemonic::from_entropy(&self.entropy, Language::English)
            .expect("entropy should be valid!");
        mnemonic.into_phrase()
    }

    pub fn clean(mut self) {
        self.entropy.zeroize();
        drop(self.pair);
    }

    pub fn pair(&self) -> &Pair {
        &self.pair
    }

    pub fn entropy(&self) -> &[u8] {
        self.entropy.as_slice()
    }
}

#[cfg(test)]
mod test_keypair {
    use super::*;
    use substrate_subxt::sp_core::Pair;

    #[test]
    fn test_create() {
        let config = KeyPairConfig {
            word_count: NonZeroUsize::new(12).unwrap(),
        };
        let keypair = KeyPair::new(config, "super-secret");
        assert_eq!(keypair.entropy().len(), 16);
        keypair.clean();
    }

    #[test]
    fn test_init() {
        let config = KeyPairConfig {
            word_count: NonZeroUsize::new(12).unwrap(),
        };
        let keypair = KeyPair::new(config, "super-secret");
        let keypair2 =
            KeyPair::init(keypair.entropy().to_owned(), "super-secret");
        assert_eq!(keypair.pair().public(), keypair2.pair().public());
        keypair.clean();
        keypair2.clean();
    }
    #[test]
    fn test_backup_restore() {
        let config = KeyPairConfig {
            word_count: NonZeroUsize::new(12).unwrap(),
        };
        let keypair = KeyPair::new(config, "super-secret");
        let phrase = keypair.backup();
        let keypair2 = KeyPair::restore(&phrase, "super-secret").unwrap();
        assert_eq!(keypair.pair().public(), keypair2.pair().public());
        keypair.clean();
        keypair2.clean();
    }
}
