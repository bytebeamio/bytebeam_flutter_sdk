pub mod logger;
pub mod types;

use crate::frb_generated::FLUTTER_RUST_BRIDGE_HANDLER;
use anyhow::{Context, Error};
use flutter_rust_bridge::{BaseAsyncRuntime, DartFnFuture};
use std::ops::Deref;
use std::sync::{Arc, Mutex};
pub use uplink::ActionCallback;
use uplink::UplinkController;

static UPLINK_INSTANCE: Mutex<Option<UplinkController>> = Mutex::new(None);

#[flutter_rust_bridge::frb(sync)]
pub fn sdk_initialized() -> bool {
    UPLINK_INSTANCE.lock().unwrap().is_some()
}

#[flutter_rust_bridge::frb(sync)]
pub fn initialize_bytebeam_sdk(
    device_json: String,
    config_toml: String,
    actions_callback: impl Fn(types::Action) -> DartFnFuture<()> + Send + Sync + 'static,
) -> anyhow::Result<()> {
    {
        let lock = UPLINK_INSTANCE.lock().unwrap();
        if let Some(sdk) = lock.deref() {
            log::warn!("terminating old bytebeam connection");
            let ctrl = sdk.shutdown.clone();
            FLUTTER_RUST_BRIDGE_HANDLER
                .async_runtime()
                .spawn(async move { ctrl.trigger_shutdown().await; });
        }
    }

    let actions_callback = Arc::new(actions_callback);
    let controller = uplink::entrypoint(
        device_json,
        config_toml,
        Some(Box::new(move |a: uplink::Action| {
            FLUTTER_RUST_BRIDGE_HANDLER
                .async_runtime()
                .spawn(actions_callback(types::Action {
                    action_id: a.action_id,
                    name: a.name,
                    payload: a.payload,
                }));
        })),
    )
    .context("couldn't initialize uplink")?;
    *UPLINK_INSTANCE.lock().unwrap() = Some(controller);
    Ok(())
}

#[flutter_rust_bridge::frb(sync)]
pub fn send_message(payload: types::BytebeamPayload) -> anyhow::Result<()> {
    let sdk = UPLINK_INSTANCE.lock().unwrap();
    match sdk.deref() {
        None => {
            log::error!("sdk hasn't been initialized");
            Err(Error::msg("sdk hasn't been initialized"))
        }
        Some(sdk) => {
            sdk.data_tx.send(payload.to_uplink_payload())?;
            Ok(())
        }
    }
}
