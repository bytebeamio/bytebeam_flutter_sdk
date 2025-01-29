use std::io::Write;

use anyhow::Result;
use tracing_subscriber::{fmt::MakeWriter, EnvFilter};
use crate::frb_generated::StreamSink;

struct LogSink {
    sink: StreamSink<String>,
}

impl<'a> Write for &'a LogSink {
    fn write(&mut self, buf: &[u8]) -> std::io::Result<usize> {
        let line = String::from_utf8_lossy(buf).to_string();
        let _ = self.sink.add(line);
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

#[flutter_rust_bridge::frb(sync)]
pub fn setup_logs(sink: StreamSink<String>) -> Result<()> {
    let log_sink = LogSink { sink };

    let _ = tracing_subscriber::fmt()
        .with_ansi(false)
        .with_max_level(tracing::Level::TRACE)
        .with_env_filter(EnvFilter::new("info,uplink::base::serializer=warn,uplink::base::mqtt=warn,uplink::base::bridge::stream=warn"))
        .compact()
        .with_writer(log_sink)
        .try_init();

    Ok(())
}