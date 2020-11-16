use crate::{crypto::KeyPair, error::Error, models::AccountInfo};
use substrate_subxt::{
    balances::{TransferCallExt, TransferEventExt},
    sp_core::crypto::{AccountId32, Ss58Codec},
    system::AccountStoreExt,
    Client, ClientBuilder, DefaultNodeRuntime, PairSigner,
};

pub struct RpcClient {
    inner: Client<DefaultNodeRuntime>,
}

impl RpcClient {
    pub async fn init(url: &str) -> Result<Self, Error> {
        let inner = ClientBuilder::new().set_url(url).build().await?;
        Ok(Self { inner })
    }

    pub async fn query_account_info(
        &self,
        ss58: &str,
    ) -> Result<AccountInfo, Error> {
        let account_id =
            AccountId32::from_ss58check(ss58).map_err(Error::PublicError)?;
        let info = self.inner.account(&account_id, None).await?;
        let data = AccountInfo::new(
            info.data.free,
            info.data.reserved,
            info.data.misc_frozen,
            info.data.fee_frozen,
        );
        Ok(data)
    }

    pub async fn balance_transfer(
        &self,
        from: &KeyPair,
        to_ss58: &str,
        amount: u128,
    ) -> Result<(), Error> {
        let signer = PairSigner::new(from.pair().clone());
        let to = AccountId32::from_ss58check(to_ss58)
            .map_err(Error::PublicError)?
            .into();
        let result =
            self.inner.transfer_and_watch(&signer, &to, amount).await?;
        match result.transfer() {
            Ok(Some(_)) => Ok(()),
            Ok(None) => {
                Err(anyhow::anyhow!("No Event found for this transfer.").into())
            },
            Err(e) => Err(anyhow::anyhow!("Transfer Failed: {}", e).into()),
        }
    }
}
