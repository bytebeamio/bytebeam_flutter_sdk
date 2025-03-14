
use crate::types::StreamMessageHttp;
use anyhow::Context;
use serde::Deserialize;
use std::collections::HashMap;
use std::sync::Arc;
use std::time::Duration;
use ureq::tls::{Certificate, ClientCert, PrivateKey, RootCerts};
pub mod logger;
pub use ureq::Agent;

#[derive(Debug, Clone, Deserialize)]
pub struct BytebeamCredentials {
    pub project_id: String,
    pub device_id: String,
    pub api_url: String,
    pub authentication: BytebeamCertificates,
}

#[derive(Debug, Clone, Deserialize)]
pub struct BytebeamCertificates {
    pub ca_certificate: String,
    pub device_certificate: String,
    pub device_private_key: String,
}

pub struct BytebeamSdk {
    pub credentials: BytebeamCredentials,
    http_client: Agent,
}

impl BytebeamSdk {
    pub fn parse(creds: String) -> Result<Self, String> {
        Self::parse_impl(&creds).map_err(|e| format!("invalid credentials: {e:?}"))
    }

    fn parse_impl(creds: &str) -> anyhow::Result<Self> {
        let credentials = serde_json::from_str::<BytebeamCredentials>(creds)?;

        let http_client =
            create_agent(&credentials.authentication).context("invalid certificates")?;

        Ok(BytebeamSdk {
            credentials,
            http_client,
        })
    }

    pub async fn fetch_available_update(&self) -> Result<Option<AvailableUpdate>, String> {
        let body = self
            .http_client
            .get(format!(
                "{}/v1/available_action/update_firmware",
                self.credentials.api_url
            ))
            .call()
            .map_err(|e| format!("connection error: {e:?}"))?
            .into_body()
            .read_to_string()
            .map_err(|e| format!("http request failed: {e:?}"))?;

        let parsed_body =
            serde_json::from_str::<AvailableUpdateResponse>(body.as_str()).map_err(|_| body)?;

        match parsed_body {
            AvailableUpdateResponse::Error { message } => Err(message),
            AvailableUpdateResponse::Ok { action } => Ok(action),
        }
    }

    pub async fn download_firmware(&self, url: &str) -> Result<Vec<u8>, String> {
        let resp = self
            .http_client
            .get(url)
            .call()
            .map_err(|e| format!("connection error: {e:?}"))?;
        if !resp.status().is_success() {
            return Err(format!(
                "download failed! http code: {}",
                resp.status().as_u16()
            ));
        }
        let body = resp
            .into_body()
            .read_to_vec()
            .map_err(|e| format!("couldn't download file: {e:?}"))?;
        Ok(body)
    }

    pub async fn upload_messages_batch_ffi(
        &self,
        stream: String,
        messages: Vec<StreamMessageFfi>,
    ) -> Result<(), String> {
        let resp = self
            .http_client
            .post(&format!(
                "{}/v1/streams/{}/submit",
                self.credentials.api_url,
                stream
            ))
            .send_json(
                messages
                    .into_iter()
                    .map(|message| StreamMessageHttp::from_application_payload(message))
                    .collect::<Vec<_>>(),
            )
            .map_err(|e| format!("http error: {e:?}"))?
            .into_body()
            .read_to_string()
            .map_err(|e| format!("http request failed: {e:?}"))?;

        let resp = serde_json::from_str::<UploadMessageResponse>(&resp).map_err(|_| resp)?;

        match resp {
            UploadMessageResponse::Error { message } => Err(message),
            UploadMessageResponse::Ok => Ok(()),
        }
    }
}

fn create_agent(creds: &BytebeamCertificates) -> anyhow::Result<Agent> {
    let tls_config = ureq::tls::TlsConfig::builder()
        .root_certs(RootCerts::Specific(Arc::new(vec![Certificate::from_pem(
            creds.ca_certificate.as_bytes(),
        )?])))
        .client_cert(Some(ClientCert::new_with_certs(
            &[Certificate::from_pem(creds.device_certificate.as_bytes())?],
            PrivateKey::from_pem(creds.device_private_key.as_bytes())?,
        )))
        .build();
    let agent_config = Agent::config_builder()
        .tls_config(tls_config)
        .timeout_global(Some(Duration::from_secs(5)))
        .build();

    Ok(Agent::from(agent_config))
}

#[derive(Deserialize)]
#[serde(tag = "status", rename_all = "lowercase")]
pub enum AvailableUpdateResponse {
    Error { message: String },
    Ok { action: Option<AvailableUpdate> },
}

#[derive(Deserialize)]
pub struct AvailableUpdate {
    pub action_id: String,
    pub params: UpdateParams,
}

#[derive(Deserialize)]
pub struct UpdateParams {
    pub url: String,
    pub version: String,
    pub checksum: Option<String>,
    #[serde(rename = "content-length")]
    pub size: u32,
}

#[derive(Deserialize)]
#[serde(tag = "status", rename_all = "lowercase")]
pub enum UploadMessageResponse {
    Error { message: String },
    Ok,
}

pub struct StreamMessageFfi {
    pub sequence: u32,
    pub timestamp: u64,
    pub fields: HashMap<String, FieldValue>,
}

#[derive(Debug, Clone)]
pub enum FieldValue {
    Null,
    String(String),
    Int(i64),
    Bool(bool),
    Float(f64),
    Array(Vec<FieldValue>),
}
