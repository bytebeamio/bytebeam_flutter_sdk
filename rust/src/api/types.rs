use std::collections::HashMap;

#[derive(Debug, Clone)]
pub struct Action {
    pub action_id: String,
    pub name: String,
    pub payload: String,
}

#[derive(Debug, Clone)]
pub struct BytebeamPayload {
    pub stream: String,
    pub sequence: u32,
    pub timestamp: u64,
    pub payload: HashMap<String, FieldValue>,
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