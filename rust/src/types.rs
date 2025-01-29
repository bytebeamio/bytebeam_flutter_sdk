use serde_json::{Number, Value};
use crate::api::types::{FieldValue, BytebeamPayload};

impl BytebeamPayload {
    pub fn to_uplink_payload(self) -> uplink::base::bridge::Payload {
        let mut fields = serde_json::Map::new();
        for (k, v) in self.payload {
            fields.insert(k, v.to_serde_value());
        }

        uplink::base::bridge::Payload {
            stream: self.stream,
            sequence: self.sequence,
            timestamp: self.timestamp,
            payload: Value::Object(fields),
        }
    }
}

impl FieldValue {
    fn to_serde_value(self) -> Value {
        match self {
            FieldValue::Null => Value::Null,
            FieldValue::String(s) => Value::String(s),
            FieldValue::Int(i) => Value::Number(Number::from_i128(i as _).unwrap()),
            FieldValue::Bool(b) => Value::Bool(b),
            FieldValue::Float(f) => Value::Number(Number::from_f64(f).unwrap()),
            FieldValue::Array(v) => Value::Array(v.into_iter().map(|i| i.to_serde_value()).collect())
        }
    }
}
