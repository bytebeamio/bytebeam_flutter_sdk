use serde::Serialize;
use serde_json::{Number, Value};
use crate::api::{FieldValue, StreamMessageFfi};

#[derive(Serialize, Debug)]
pub struct StreamMessageHttp {
    sequence: u32,
    timestamp: u64,
    #[serde(flatten)]
    fields: Value,
}

impl FieldValue {
    pub fn to_serde_value(self) -> Value {
        match self {
            FieldValue::Null => Value::Null,
            FieldValue::String(s) => Value::String(s),
            FieldValue::Int(i) => Value::Number(Number::from_i128(i as _).unwrap()),
            FieldValue::Bool(b) => Value::Bool(b),
            FieldValue::Float(f) => Value::Number(Number::from_f64(f).unwrap()),
            FieldValue::Array(v) => {
                Value::Array(v.into_iter().map(|i| i.to_serde_value()).collect())
            }
        }
    }
}

impl StreamMessageHttp {
    pub fn from_application_payload(m: StreamMessageFfi) -> Self {
        let mut fields = serde_json::Map::new();
        for (k, v) in m.fields {
            fields.insert(k, v.to_serde_value());
        }

        StreamMessageHttp {
            sequence: m.sequence,
            timestamp: m.timestamp,
            fields: Value::Object(fields),
        }
    }
}

