use std::io::Write;
use std::sync::Mutex;
use anyhow::Result;
use tracing_subscriber::{fmt::MakeWriter, EnvFilter};
use crate::frb_generated::StreamSink;

static CURRENT_LOG_SINK: Mutex<Option<StreamSink<String>>> = Mutex::new(None);
struct LogSink;

impl<'a> Write for &'a LogSink {
    fn write(&mut self, buf: &[u8]) -> std::io::Result<usize> {
        if let Ok(mg) = CURRENT_LOG_SINK.lock() {
            if let Some(sink) = mg.as_ref() {
                let line = String::from_utf8_lossy(buf).to_string();
                let _ = sink.add(line);
            }
        }
        Ok(buf.len())
    }

    fn flush(&mut self) -> std::io::Result<()> {
        Ok(())
    }
}

impl<'a> MakeWriter<'a> for LogSink {
    type Writer = &'a LogSink;

    fn make_writer(&'a self) -> Self::Writer {
        self
    }
}

#[flutter_rust_bridge::frb]
pub fn setup_logs(sink: StreamSink<String>) -> Result<()> {
    match CURRENT_LOG_SINK.lock() {
        Ok(mut ptr) => {
            *ptr = Some(sink);
        }
        Err(_) => {
            log::error!("log sink poisoned!");
        }
    }

    let _ = tracing_subscriber::fmt()
        .with_ansi(false)
        .with_max_level(tracing::Level::TRACE)
        .with_env_filter(EnvFilter::new("info"))
        .compact()
        .with_writer(LogSink)
        .try_init();

    Ok(())
}