use crate::error::Error;
use substrate_subxt::{
    sp_core::crypto::{AccountId32, Ss58Codec},
    system::AccountStoreExt,
    Client, ClientBuilder, DefaultNodeRuntime,
};

use crate::models::AccountInfo;

pub struct RpcClient {
    inner: Client<DefaultNodeRuntime>,
}

impl RpcClient {
    pub async fn init(url: String) -> Result<Self, Error> {
        let inner = ClientBuilder::new().set_url(url).build().await?;
        Ok(Self { inner })
    }

    pub async fn query_account_info(
        &self,
        ss58: String,
    ) -> Result<AccountInfo, Error> {
        let account_id =
            AccountId32::from_ss58check(&ss58).map_err(Error::PublicError)?;
        let info = self.inner.account(&account_id, None).await?;
        let data = AccountInfo::new(
            info.data.free,
            info.data.reserved,
            info.data.misc_frozen,
            info.data.fee_frozen,
        );
        Ok(data)
    }
}
