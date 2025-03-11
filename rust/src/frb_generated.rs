// This file is automatically generated, so please do not edit it.
// @generated by `flutter_rust_bridge`@ 2.7.0.

#![allow(
    non_camel_case_types,
    unused,
    non_snake_case,
    clippy::needless_return,
    clippy::redundant_closure_call,
    clippy::redundant_closure,
    clippy::useless_conversion,
    clippy::unit_arg,
    clippy::unused_unit,
    clippy::double_parens,
    clippy::let_and_return,
    clippy::too_many_arguments,
    clippy::match_single_binding,
    clippy::clone_on_copy,
    clippy::let_unit_value,
    clippy::deref_addrof,
    clippy::explicit_auto_deref,
    clippy::borrow_deref_ref,
    clippy::needless_borrow
)]

// Section: imports

use crate::api::*;
use flutter_rust_bridge::for_generated::byteorder::{NativeEndian, ReadBytesExt, WriteBytesExt};
use flutter_rust_bridge::for_generated::{transform_result_dco, Lifetimeable, Lockable};
use flutter_rust_bridge::{Handler, IntoIntoDart};

// Section: boilerplate

flutter_rust_bridge::frb_generated_boilerplate!(
    default_stream_sink_codec = SseCodec,
    default_rust_opaque = RustOpaqueMoi,
    default_rust_auto_opaque = RustAutoOpaqueMoi,
);
pub(crate) const FLUTTER_RUST_BRIDGE_CODEGEN_VERSION: &str = "2.7.0";
pub(crate) const FLUTTER_RUST_BRIDGE_CODEGEN_CONTENT_HASH: i32 = 1823117066;

// Section: executor

flutter_rust_bridge::frb_generated_default_handler!();

// Section: wire_funcs

fn wire__crate__api__BytebeamSdk_auto_accessor_get_credentials_impl(
    ptr_: flutter_rust_bridge::for_generated::PlatformGeneralizedUint8ListPtr,
    rust_vec_len_: i32,
    data_len_: i32,
) -> flutter_rust_bridge::for_generated::WireSyncRust2DartSse {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap_sync::<flutter_rust_bridge::for_generated::SseCodec, _>(
        flutter_rust_bridge::for_generated::TaskInfo {
            debug_name: "BytebeamSdk_auto_accessor_get_credentials",
            port: None,
            mode: flutter_rust_bridge::for_generated::FfiCallMode::Sync,
        },
        move || {
            let message = unsafe {
                flutter_rust_bridge::for_generated::Dart2RustMessageSse::from_wire(
                    ptr_,
                    rust_vec_len_,
                    data_len_,
                )
            };
            let mut deserializer =
                flutter_rust_bridge::for_generated::SseDeserializer::new(message);
            let api_that = <RustOpaqueMoi<
                flutter_rust_bridge::for_generated::RustAutoOpaqueInner<BytebeamSdk>,
            >>::sse_decode(&mut deserializer);
            deserializer.end();
            transform_result_sse::<_, ()>((move || {
                let mut api_that_guard = None;
                let decode_indices_ =
                    flutter_rust_bridge::for_generated::lockable_compute_decode_order(vec![
                        flutter_rust_bridge::for_generated::LockableOrderInfo::new(
                            &api_that, 0, false,
                        ),
                    ]);
                for i in decode_indices_ {
                    match i {
                        0 => api_that_guard = Some(api_that.lockable_decode_sync_ref()),
                        _ => unreachable!(),
                    }
                }
                let api_that_guard = api_that_guard.unwrap();
                let output_ok = Result::<_, ()>::Ok(api_that_guard.credentials.clone())?;
                Ok(output_ok)
            })())
        },
    )
}
fn wire__crate__api__BytebeamSdk_auto_accessor_set_credentials_impl(
    ptr_: flutter_rust_bridge::for_generated::PlatformGeneralizedUint8ListPtr,
    rust_vec_len_: i32,
    data_len_: i32,
) -> flutter_rust_bridge::for_generated::WireSyncRust2DartSse {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap_sync::<flutter_rust_bridge::for_generated::SseCodec, _>(
        flutter_rust_bridge::for_generated::TaskInfo {
            debug_name: "BytebeamSdk_auto_accessor_set_credentials",
            port: None,
            mode: flutter_rust_bridge::for_generated::FfiCallMode::Sync,
        },
        move || {
            let message = unsafe {
                flutter_rust_bridge::for_generated::Dart2RustMessageSse::from_wire(
                    ptr_,
                    rust_vec_len_,
                    data_len_,
                )
            };
            let mut deserializer =
                flutter_rust_bridge::for_generated::SseDeserializer::new(message);
            let api_that = <RustOpaqueMoi<
                flutter_rust_bridge::for_generated::RustAutoOpaqueInner<BytebeamSdk>,
            >>::sse_decode(&mut deserializer);
            let api_credentials = <crate::api::BytebeamCredentials>::sse_decode(&mut deserializer);
            deserializer.end();
            transform_result_sse::<_, ()>((move || {
                let mut api_that_guard = None;
                let decode_indices_ =
                    flutter_rust_bridge::for_generated::lockable_compute_decode_order(vec![
                        flutter_rust_bridge::for_generated::LockableOrderInfo::new(
                            &api_that, 0, true,
                        ),
                    ]);
                for i in decode_indices_ {
                    match i {
                        0 => api_that_guard = Some(api_that.lockable_decode_sync_ref_mut()),
                        _ => unreachable!(),
                    }
                }
                let mut api_that_guard = api_that_guard.unwrap();
                let output_ok = Result::<_, ()>::Ok({
                    {
                        api_that_guard.credentials = api_credentials;
                    };
                })?;
                Ok(output_ok)
            })())
        },
    )
}
fn wire__crate__api__BytebeamSdk_download_update_impl(
    port_: flutter_rust_bridge::for_generated::MessagePort,
    ptr_: flutter_rust_bridge::for_generated::PlatformGeneralizedUint8ListPtr,
    rust_vec_len_: i32,
    data_len_: i32,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap_async::<flutter_rust_bridge::for_generated::SseCodec, _, _, _>(
        flutter_rust_bridge::for_generated::TaskInfo {
            debug_name: "BytebeamSdk_download_update",
            port: Some(port_),
            mode: flutter_rust_bridge::for_generated::FfiCallMode::Normal,
        },
        move || {
            let message = unsafe {
                flutter_rust_bridge::for_generated::Dart2RustMessageSse::from_wire(
                    ptr_,
                    rust_vec_len_,
                    data_len_,
                )
            };
            let mut deserializer =
                flutter_rust_bridge::for_generated::SseDeserializer::new(message);
            let api_that = <RustOpaqueMoi<
                flutter_rust_bridge::for_generated::RustAutoOpaqueInner<BytebeamSdk>,
            >>::sse_decode(&mut deserializer);
            let api_update = <crate::api::AvailableUpdate>::sse_decode(&mut deserializer);
            deserializer.end();
            move |context| async move {
                transform_result_sse::<_, String>(
                    (move || async move {
                        let mut api_that_guard = None;
                        let decode_indices_ =
                            flutter_rust_bridge::for_generated::lockable_compute_decode_order(
                                vec![flutter_rust_bridge::for_generated::LockableOrderInfo::new(
                                    &api_that, 0, false,
                                )],
                            );
                        for i in decode_indices_ {
                            match i {
                                0 => {
                                    api_that_guard =
                                        Some(api_that.lockable_decode_async_ref().await)
                                }
                                _ => unreachable!(),
                            }
                        }
                        let api_that_guard = api_that_guard.unwrap();
                        let output_ok =
                            crate::api::BytebeamSdk::download_update(&*api_that_guard, api_update)
                                .await?;
                        Ok(output_ok)
                    })()
                    .await,
                )
            }
        },
    )
}
fn wire__crate__api__BytebeamSdk_fetch_available_update_impl(
    port_: flutter_rust_bridge::for_generated::MessagePort,
    ptr_: flutter_rust_bridge::for_generated::PlatformGeneralizedUint8ListPtr,
    rust_vec_len_: i32,
    data_len_: i32,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap_async::<flutter_rust_bridge::for_generated::SseCodec, _, _, _>(
        flutter_rust_bridge::for_generated::TaskInfo {
            debug_name: "BytebeamSdk_fetch_available_update",
            port: Some(port_),
            mode: flutter_rust_bridge::for_generated::FfiCallMode::Normal,
        },
        move || {
            let message = unsafe {
                flutter_rust_bridge::for_generated::Dart2RustMessageSse::from_wire(
                    ptr_,
                    rust_vec_len_,
                    data_len_,
                )
            };
            let mut deserializer =
                flutter_rust_bridge::for_generated::SseDeserializer::new(message);
            let api_that = <RustOpaqueMoi<
                flutter_rust_bridge::for_generated::RustAutoOpaqueInner<BytebeamSdk>,
            >>::sse_decode(&mut deserializer);
            deserializer.end();
            move |context| async move {
                transform_result_sse::<_, String>(
                    (move || async move {
                        let mut api_that_guard = None;
                        let decode_indices_ =
                            flutter_rust_bridge::for_generated::lockable_compute_decode_order(
                                vec![flutter_rust_bridge::for_generated::LockableOrderInfo::new(
                                    &api_that, 0, false,
                                )],
                            );
                        for i in decode_indices_ {
                            match i {
                                0 => {
                                    api_that_guard =
                                        Some(api_that.lockable_decode_async_ref().await)
                                }
                                _ => unreachable!(),
                            }
                        }
                        let api_that_guard = api_that_guard.unwrap();
                        let output_ok =
                            crate::api::BytebeamSdk::fetch_available_update(&*api_that_guard)
                                .await?;
                        Ok(output_ok)
                    })()
                    .await,
                )
            }
        },
    )
}
fn wire__crate__api__BytebeamSdk_parse_impl(
    port_: flutter_rust_bridge::for_generated::MessagePort,
    ptr_: flutter_rust_bridge::for_generated::PlatformGeneralizedUint8ListPtr,
    rust_vec_len_: i32,
    data_len_: i32,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap_normal::<flutter_rust_bridge::for_generated::SseCodec, _, _>(
        flutter_rust_bridge::for_generated::TaskInfo {
            debug_name: "BytebeamSdk_parse",
            port: Some(port_),
            mode: flutter_rust_bridge::for_generated::FfiCallMode::Normal,
        },
        move || {
            let message = unsafe {
                flutter_rust_bridge::for_generated::Dart2RustMessageSse::from_wire(
                    ptr_,
                    rust_vec_len_,
                    data_len_,
                )
            };
            let mut deserializer =
                flutter_rust_bridge::for_generated::SseDeserializer::new(message);
            let api_creds = <String>::sse_decode(&mut deserializer);
            deserializer.end();
            move |context| {
                transform_result_sse::<_, String>((move || {
                    let output_ok = crate::api::BytebeamSdk::parse(api_creds)?;
                    Ok(output_ok)
                })())
            }
        },
    )
}
fn wire__crate__api__logger__setup_logs_impl(
    port_: flutter_rust_bridge::for_generated::MessagePort,
    ptr_: flutter_rust_bridge::for_generated::PlatformGeneralizedUint8ListPtr,
    rust_vec_len_: i32,
    data_len_: i32,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap_normal::<flutter_rust_bridge::for_generated::SseCodec, _, _>(
        flutter_rust_bridge::for_generated::TaskInfo {
            debug_name: "setup_logs",
            port: Some(port_),
            mode: flutter_rust_bridge::for_generated::FfiCallMode::Normal,
        },
        move || {
            let message = unsafe {
                flutter_rust_bridge::for_generated::Dart2RustMessageSse::from_wire(
                    ptr_,
                    rust_vec_len_,
                    data_len_,
                )
            };
            let mut deserializer =
                flutter_rust_bridge::for_generated::SseDeserializer::new(message);
            let api_sink =
                <StreamSink<String, flutter_rust_bridge::for_generated::SseCodec>>::sse_decode(
                    &mut deserializer,
                );
            deserializer.end();
            move |context| {
                transform_result_sse::<_, flutter_rust_bridge::for_generated::anyhow::Error>(
                    (move || {
                        let output_ok = crate::api::logger::setup_logs(api_sink)?;
                        Ok(output_ok)
                    })(),
                )
            }
        },
    )
}

// Section: related_funcs

flutter_rust_bridge::frb_generated_moi_arc_impl_value!(
    flutter_rust_bridge::for_generated::RustAutoOpaqueInner<BytebeamSdk>
);

// Section: dart2rust

impl SseDecode for flutter_rust_bridge::for_generated::anyhow::Error {
    // Codec=Sse (Serialization based), see doc to use other codecs
    fn sse_decode(deserializer: &mut flutter_rust_bridge::for_generated::SseDeserializer) -> Self {
        let mut inner = <String>::sse_decode(deserializer);
        return flutter_rust_bridge::for_generated::anyhow::anyhow!("{}", inner);
    }
}

impl SseDecode for BytebeamSdk {
    // Codec=Sse (Serialization based), see doc to use other codecs
    fn sse_decode(deserializer: &mut flutter_rust_bridge::for_generated::SseDeserializer) -> Self {
        let mut inner = <RustOpaqueMoi<
            flutter_rust_bridge::for_generated::RustAutoOpaqueInner<BytebeamSdk>,
        >>::sse_decode(deserializer);
        return flutter_rust_bridge::for_generated::rust_auto_opaque_decode_owned(inner);
    }
}

impl SseDecode
    for RustOpaqueMoi<flutter_rust_bridge::for_generated::RustAutoOpaqueInner<BytebeamSdk>>
{
    // Codec=Sse (Serialization based), see doc to use other codecs
    fn sse_decode(deserializer: &mut flutter_rust_bridge::for_generated::SseDeserializer) -> Self {
        let mut inner = <usize>::sse_decode(deserializer);
        return decode_rust_opaque_moi(inner);
    }
}

impl SseDecode for StreamSink<String, flutter_rust_bridge::for_generated::SseCodec> {
    // Codec=Sse (Serialization based), see doc to use other codecs
    fn sse_decode(deserializer: &mut flutter_rust_bridge::for_generated::SseDeserializer) -> Self {
        let mut inner = <String>::sse_decode(deserializer);
        return StreamSink::deserialize(inner);
    }
}

impl SseDecode for String {
    // Codec=Sse (Serialization based), see doc to use other codecs
    fn sse_decode(deserializer: &mut flutter_rust_bridge::for_generated::SseDeserializer) -> Self {
        let mut inner = <Vec<u8>>::sse_decode(deserializer);
        return String::from_utf8(inner).unwrap();
    }
}

impl SseDecode for crate::api::AvailableUpdate {
    // Codec=Sse (Serialization based), see doc to use other codecs
    fn sse_decode(deserializer: &mut flutter_rust_bridge::for_generated::SseDeserializer) -> Self {
        let mut var_actionId = <String>::sse_decode(deserializer);
        let mut var_url = <String>::sse_decode(deserializer);
        let mut var_version = <String>::sse_decode(deserializer);
        let mut var_checksum = <String>::sse_decode(deserializer);
        let mut var_size = <u32>::sse_decode(deserializer);
        return crate::api::AvailableUpdate {
            action_id: var_actionId,
            url: var_url,
            version: var_version,
            checksum: var_checksum,
            size: var_size,
        };
    }
}

impl SseDecode for crate::api::BytebeamCertificates {
    // Codec=Sse (Serialization based), see doc to use other codecs
    fn sse_decode(deserializer: &mut flutter_rust_bridge::for_generated::SseDeserializer) -> Self {
        let mut var_caCertificate = <String>::sse_decode(deserializer);
        let mut var_deviceCertificate = <String>::sse_decode(deserializer);
        let mut var_devicePrivateKey = <String>::sse_decode(deserializer);
        return crate::api::BytebeamCertificates {
            ca_certificate: var_caCertificate,
            device_certificate: var_deviceCertificate,
            device_private_key: var_devicePrivateKey,
        };
    }
}

impl SseDecode for crate::api::BytebeamCredentials {
    // Codec=Sse (Serialization based), see doc to use other codecs
    fn sse_decode(deserializer: &mut flutter_rust_bridge::for_generated::SseDeserializer) -> Self {
        let mut var_projectId = <String>::sse_decode(deserializer);
        let mut var_deviceId = <String>::sse_decode(deserializer);
        let mut var_apiUrl = <String>::sse_decode(deserializer);
        let mut var_authentication = <crate::api::BytebeamCertificates>::sse_decode(deserializer);
        return crate::api::BytebeamCredentials {
            project_id: var_projectId,
            device_id: var_deviceId,
            api_url: var_apiUrl,
            authentication: var_authentication,
        };
    }
}

impl SseDecode for Vec<u8> {
    // Codec=Sse (Serialization based), see doc to use other codecs
    fn sse_decode(deserializer: &mut flutter_rust_bridge::for_generated::SseDeserializer) -> Self {
        let mut len_ = <i32>::sse_decode(deserializer);
        let mut ans_ = vec![];
        for idx_ in 0..len_ {
            ans_.push(<u8>::sse_decode(deserializer));
        }
        return ans_;
    }
}

impl SseDecode for Option<crate::api::AvailableUpdate> {
    // Codec=Sse (Serialization based), see doc to use other codecs
    fn sse_decode(deserializer: &mut flutter_rust_bridge::for_generated::SseDeserializer) -> Self {
        if (<bool>::sse_decode(deserializer)) {
            return Some(<crate::api::AvailableUpdate>::sse_decode(deserializer));
        } else {
            return None;
        }
    }
}

impl SseDecode for u32 {
    // Codec=Sse (Serialization based), see doc to use other codecs
    fn sse_decode(deserializer: &mut flutter_rust_bridge::for_generated::SseDeserializer) -> Self {
        deserializer.cursor.read_u32::<NativeEndian>().unwrap()
    }
}

impl SseDecode for u8 {
    // Codec=Sse (Serialization based), see doc to use other codecs
    fn sse_decode(deserializer: &mut flutter_rust_bridge::for_generated::SseDeserializer) -> Self {
        deserializer.cursor.read_u8().unwrap()
    }
}

impl SseDecode for () {
    // Codec=Sse (Serialization based), see doc to use other codecs
    fn sse_decode(deserializer: &mut flutter_rust_bridge::for_generated::SseDeserializer) -> Self {}
}

impl SseDecode for usize {
    // Codec=Sse (Serialization based), see doc to use other codecs
    fn sse_decode(deserializer: &mut flutter_rust_bridge::for_generated::SseDeserializer) -> Self {
        deserializer.cursor.read_u64::<NativeEndian>().unwrap() as _
    }
}

impl SseDecode for i32 {
    // Codec=Sse (Serialization based), see doc to use other codecs
    fn sse_decode(deserializer: &mut flutter_rust_bridge::for_generated::SseDeserializer) -> Self {
        deserializer.cursor.read_i32::<NativeEndian>().unwrap()
    }
}

impl SseDecode for bool {
    // Codec=Sse (Serialization based), see doc to use other codecs
    fn sse_decode(deserializer: &mut flutter_rust_bridge::for_generated::SseDeserializer) -> Self {
        deserializer.cursor.read_u8().unwrap() != 0
    }
}

fn pde_ffi_dispatcher_primary_impl(
    func_id: i32,
    port: flutter_rust_bridge::for_generated::MessagePort,
    ptr: flutter_rust_bridge::for_generated::PlatformGeneralizedUint8ListPtr,
    rust_vec_len: i32,
    data_len: i32,
) {
    // Codec=Pde (Serialization + dispatch), see doc to use other codecs
    match func_id {
        3 => wire__crate__api__BytebeamSdk_download_update_impl(port, ptr, rust_vec_len, data_len),
        4 => wire__crate__api__BytebeamSdk_fetch_available_update_impl(
            port,
            ptr,
            rust_vec_len,
            data_len,
        ),
        5 => wire__crate__api__BytebeamSdk_parse_impl(port, ptr, rust_vec_len, data_len),
        6 => wire__crate__api__logger__setup_logs_impl(port, ptr, rust_vec_len, data_len),
        _ => unreachable!(),
    }
}

fn pde_ffi_dispatcher_sync_impl(
    func_id: i32,
    ptr: flutter_rust_bridge::for_generated::PlatformGeneralizedUint8ListPtr,
    rust_vec_len: i32,
    data_len: i32,
) -> flutter_rust_bridge::for_generated::WireSyncRust2DartSse {
    // Codec=Pde (Serialization + dispatch), see doc to use other codecs
    match func_id {
        1 => wire__crate__api__BytebeamSdk_auto_accessor_get_credentials_impl(
            ptr,
            rust_vec_len,
            data_len,
        ),
        2 => wire__crate__api__BytebeamSdk_auto_accessor_set_credentials_impl(
            ptr,
            rust_vec_len,
            data_len,
        ),
        _ => unreachable!(),
    }
}

// Section: rust2dart

// Codec=Dco (DartCObject based), see doc to use other codecs
impl flutter_rust_bridge::IntoDart for FrbWrapper<BytebeamSdk> {
    fn into_dart(self) -> flutter_rust_bridge::for_generated::DartAbi {
        flutter_rust_bridge::for_generated::rust_auto_opaque_encode::<_, MoiArc<_>>(self.0)
            .into_dart()
    }
}
impl flutter_rust_bridge::for_generated::IntoDartExceptPrimitive for FrbWrapper<BytebeamSdk> {}

impl flutter_rust_bridge::IntoIntoDart<FrbWrapper<BytebeamSdk>> for BytebeamSdk {
    fn into_into_dart(self) -> FrbWrapper<BytebeamSdk> {
        self.into()
    }
}

// Codec=Dco (DartCObject based), see doc to use other codecs
impl flutter_rust_bridge::IntoDart for crate::api::AvailableUpdate {
    fn into_dart(self) -> flutter_rust_bridge::for_generated::DartAbi {
        [
            self.action_id.into_into_dart().into_dart(),
            self.url.into_into_dart().into_dart(),
            self.version.into_into_dart().into_dart(),
            self.checksum.into_into_dart().into_dart(),
            self.size.into_into_dart().into_dart(),
        ]
        .into_dart()
    }
}
impl flutter_rust_bridge::for_generated::IntoDartExceptPrimitive for crate::api::AvailableUpdate {}
impl flutter_rust_bridge::IntoIntoDart<crate::api::AvailableUpdate>
    for crate::api::AvailableUpdate
{
    fn into_into_dart(self) -> crate::api::AvailableUpdate {
        self
    }
}
// Codec=Dco (DartCObject based), see doc to use other codecs
impl flutter_rust_bridge::IntoDart for crate::api::BytebeamCertificates {
    fn into_dart(self) -> flutter_rust_bridge::for_generated::DartAbi {
        [
            self.ca_certificate.into_into_dart().into_dart(),
            self.device_certificate.into_into_dart().into_dart(),
            self.device_private_key.into_into_dart().into_dart(),
        ]
        .into_dart()
    }
}
impl flutter_rust_bridge::for_generated::IntoDartExceptPrimitive
    for crate::api::BytebeamCertificates
{
}
impl flutter_rust_bridge::IntoIntoDart<crate::api::BytebeamCertificates>
    for crate::api::BytebeamCertificates
{
    fn into_into_dart(self) -> crate::api::BytebeamCertificates {
        self
    }
}
// Codec=Dco (DartCObject based), see doc to use other codecs
impl flutter_rust_bridge::IntoDart for crate::api::BytebeamCredentials {
    fn into_dart(self) -> flutter_rust_bridge::for_generated::DartAbi {
        [
            self.project_id.into_into_dart().into_dart(),
            self.device_id.into_into_dart().into_dart(),
            self.api_url.into_into_dart().into_dart(),
            self.authentication.into_into_dart().into_dart(),
        ]
        .into_dart()
    }
}
impl flutter_rust_bridge::for_generated::IntoDartExceptPrimitive
    for crate::api::BytebeamCredentials
{
}
impl flutter_rust_bridge::IntoIntoDart<crate::api::BytebeamCredentials>
    for crate::api::BytebeamCredentials
{
    fn into_into_dart(self) -> crate::api::BytebeamCredentials {
        self
    }
}

impl SseEncode for flutter_rust_bridge::for_generated::anyhow::Error {
    // Codec=Sse (Serialization based), see doc to use other codecs
    fn sse_encode(self, serializer: &mut flutter_rust_bridge::for_generated::SseSerializer) {
        <String>::sse_encode(format!("{:?}", self), serializer);
    }
}

impl SseEncode for BytebeamSdk {
    // Codec=Sse (Serialization based), see doc to use other codecs
    fn sse_encode(self, serializer: &mut flutter_rust_bridge::for_generated::SseSerializer) {
        <RustOpaqueMoi<flutter_rust_bridge::for_generated::RustAutoOpaqueInner<BytebeamSdk>>>::sse_encode(flutter_rust_bridge::for_generated::rust_auto_opaque_encode::<_, MoiArc<_>>(self), serializer);
    }
}

impl SseEncode
    for RustOpaqueMoi<flutter_rust_bridge::for_generated::RustAutoOpaqueInner<BytebeamSdk>>
{
    // Codec=Sse (Serialization based), see doc to use other codecs
    fn sse_encode(self, serializer: &mut flutter_rust_bridge::for_generated::SseSerializer) {
        let (ptr, size) = self.sse_encode_raw();
        <usize>::sse_encode(ptr, serializer);
        <i32>::sse_encode(size, serializer);
    }
}

impl SseEncode for StreamSink<String, flutter_rust_bridge::for_generated::SseCodec> {
    // Codec=Sse (Serialization based), see doc to use other codecs
    fn sse_encode(self, serializer: &mut flutter_rust_bridge::for_generated::SseSerializer) {
        unimplemented!("")
    }
}

impl SseEncode for String {
    // Codec=Sse (Serialization based), see doc to use other codecs
    fn sse_encode(self, serializer: &mut flutter_rust_bridge::for_generated::SseSerializer) {
        <Vec<u8>>::sse_encode(self.into_bytes(), serializer);
    }
}

impl SseEncode for crate::api::AvailableUpdate {
    // Codec=Sse (Serialization based), see doc to use other codecs
    fn sse_encode(self, serializer: &mut flutter_rust_bridge::for_generated::SseSerializer) {
        <String>::sse_encode(self.action_id, serializer);
        <String>::sse_encode(self.url, serializer);
        <String>::sse_encode(self.version, serializer);
        <String>::sse_encode(self.checksum, serializer);
        <u32>::sse_encode(self.size, serializer);
    }
}

impl SseEncode for crate::api::BytebeamCertificates {
    // Codec=Sse (Serialization based), see doc to use other codecs
    fn sse_encode(self, serializer: &mut flutter_rust_bridge::for_generated::SseSerializer) {
        <String>::sse_encode(self.ca_certificate, serializer);
        <String>::sse_encode(self.device_certificate, serializer);
        <String>::sse_encode(self.device_private_key, serializer);
    }
}

impl SseEncode for crate::api::BytebeamCredentials {
    // Codec=Sse (Serialization based), see doc to use other codecs
    fn sse_encode(self, serializer: &mut flutter_rust_bridge::for_generated::SseSerializer) {
        <String>::sse_encode(self.project_id, serializer);
        <String>::sse_encode(self.device_id, serializer);
        <String>::sse_encode(self.api_url, serializer);
        <crate::api::BytebeamCertificates>::sse_encode(self.authentication, serializer);
    }
}

impl SseEncode for Vec<u8> {
    // Codec=Sse (Serialization based), see doc to use other codecs
    fn sse_encode(self, serializer: &mut flutter_rust_bridge::for_generated::SseSerializer) {
        <i32>::sse_encode(self.len() as _, serializer);
        for item in self {
            <u8>::sse_encode(item, serializer);
        }
    }
}

impl SseEncode for Option<crate::api::AvailableUpdate> {
    // Codec=Sse (Serialization based), see doc to use other codecs
    fn sse_encode(self, serializer: &mut flutter_rust_bridge::for_generated::SseSerializer) {
        <bool>::sse_encode(self.is_some(), serializer);
        if let Some(value) = self {
            <crate::api::AvailableUpdate>::sse_encode(value, serializer);
        }
    }
}

impl SseEncode for u32 {
    // Codec=Sse (Serialization based), see doc to use other codecs
    fn sse_encode(self, serializer: &mut flutter_rust_bridge::for_generated::SseSerializer) {
        serializer.cursor.write_u32::<NativeEndian>(self).unwrap();
    }
}

impl SseEncode for u8 {
    // Codec=Sse (Serialization based), see doc to use other codecs
    fn sse_encode(self, serializer: &mut flutter_rust_bridge::for_generated::SseSerializer) {
        serializer.cursor.write_u8(self).unwrap();
    }
}

impl SseEncode for () {
    // Codec=Sse (Serialization based), see doc to use other codecs
    fn sse_encode(self, serializer: &mut flutter_rust_bridge::for_generated::SseSerializer) {}
}

impl SseEncode for usize {
    // Codec=Sse (Serialization based), see doc to use other codecs
    fn sse_encode(self, serializer: &mut flutter_rust_bridge::for_generated::SseSerializer) {
        serializer
            .cursor
            .write_u64::<NativeEndian>(self as _)
            .unwrap();
    }
}

impl SseEncode for i32 {
    // Codec=Sse (Serialization based), see doc to use other codecs
    fn sse_encode(self, serializer: &mut flutter_rust_bridge::for_generated::SseSerializer) {
        serializer.cursor.write_i32::<NativeEndian>(self).unwrap();
    }
}

impl SseEncode for bool {
    // Codec=Sse (Serialization based), see doc to use other codecs
    fn sse_encode(self, serializer: &mut flutter_rust_bridge::for_generated::SseSerializer) {
        serializer.cursor.write_u8(self as _).unwrap();
    }
}

#[cfg(not(target_family = "wasm"))]
mod io {
    // This file is automatically generated, so please do not edit it.
    // @generated by `flutter_rust_bridge`@ 2.7.0.

    // Section: imports

    use super::*;
    use crate::api::*;
    use flutter_rust_bridge::for_generated::byteorder::{
        NativeEndian, ReadBytesExt, WriteBytesExt,
    };
    use flutter_rust_bridge::for_generated::{transform_result_dco, Lifetimeable, Lockable};
    use flutter_rust_bridge::{Handler, IntoIntoDart};

    // Section: boilerplate

    flutter_rust_bridge::frb_generated_boilerplate_io!();

    #[no_mangle]
    pub extern "C" fn frbgen_bytebeam_flutter_rust_arc_increment_strong_count_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerBytebeamSdk(
        ptr: *const std::ffi::c_void,
    ) {
        MoiArc::<flutter_rust_bridge::for_generated::RustAutoOpaqueInner<BytebeamSdk>>::increment_strong_count(ptr as _);
    }

    #[no_mangle]
    pub extern "C" fn frbgen_bytebeam_flutter_rust_arc_decrement_strong_count_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerBytebeamSdk(
        ptr: *const std::ffi::c_void,
    ) {
        MoiArc::<flutter_rust_bridge::for_generated::RustAutoOpaqueInner<BytebeamSdk>>::decrement_strong_count(ptr as _);
    }
}
#[cfg(not(target_family = "wasm"))]
pub use io::*;

/// cbindgen:ignore
#[cfg(target_family = "wasm")]
mod web {
    // This file is automatically generated, so please do not edit it.
    // @generated by `flutter_rust_bridge`@ 2.7.0.

    // Section: imports

    use super::*;
    use crate::api::*;
    use flutter_rust_bridge::for_generated::byteorder::{
        NativeEndian, ReadBytesExt, WriteBytesExt,
    };
    use flutter_rust_bridge::for_generated::wasm_bindgen;
    use flutter_rust_bridge::for_generated::wasm_bindgen::prelude::*;
    use flutter_rust_bridge::for_generated::{transform_result_dco, Lifetimeable, Lockable};
    use flutter_rust_bridge::{Handler, IntoIntoDart};

    // Section: boilerplate

    flutter_rust_bridge::frb_generated_boilerplate_web!();

    #[wasm_bindgen]
    pub fn rust_arc_increment_strong_count_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerBytebeamSdk(
        ptr: *const std::ffi::c_void,
    ) {
        MoiArc::<flutter_rust_bridge::for_generated::RustAutoOpaqueInner<BytebeamSdk>>::increment_strong_count(ptr as _);
    }

    #[wasm_bindgen]
    pub fn rust_arc_decrement_strong_count_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerBytebeamSdk(
        ptr: *const std::ffi::c_void,
    ) {
        MoiArc::<flutter_rust_bridge::for_generated::RustAutoOpaqueInner<BytebeamSdk>>::decrement_strong_count(ptr as _);
    }
}
#[cfg(target_family = "wasm")]
pub use web::*;
