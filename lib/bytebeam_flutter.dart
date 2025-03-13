library;

import 'package:bytebeam_flutter/src/rust/api.dart';
import 'package:collection/collection.dart';
export 'src/rust/api/types.dart';
import 'src/rust/frb_generated.dart' show RustLib;

Future<void> initializeNativeCode() async {
  try {
    await RustLib.init();
  } catch (e) {
    print(e);
  }
}

class StreamMessage {
  String stream;
  int sequence;
  int timestamp;
  Map<String, FieldValue> fields;

  StreamMessage._(this.stream, this.sequence, this.timestamp, this.fields);

  static StreamMessage create({
    required String stream,
    int sequence = 0,
    DateTime? timestamp,
    required Map<String, dynamic> fields
  }) {
    return StreamMessage._(
        stream, sequence,
        (timestamp ?? DateTime.now()).millisecondsSinceEpoch,
        toFieldSet(fields)
    );
  }

  StreamMessageFfi toFfi() {
    return StreamMessageFfi(
        stream: stream,
        sequence: sequence,
        timestamp: BigInt.from(timestamp),
        fields: fields
    );
  }

  @override
  String toString() {
    return 'StreamMessage(stream: $stream, sequence: $sequence, timestamp: $timestamp, fields: $fields)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StreamMessage &&
        other.stream == stream &&
        other.sequence == sequence &&
        other.timestamp == timestamp &&
        MapEquality().equals(other.fields, fields);
  }

  @override
  int get hashCode => stream.hashCode ^ sequence.hashCode ^ timestamp.hashCode ^ MapEquality().hash(fields);
}

Future<void> doStuff(String token) async {
  try {
    print("step 1");
    var sdk = await BytebeamSdk.parse(creds: token);
    print("step 2");
    var update = await sdk.fetchAvailableUpdate();
    print("update: ${update?.url} | ${update?.actionId}");
    if (update != null) {
      print("step 3");
      var payload = await sdk.downloadUpdate(update: update);
      print("received firmware of size: ${payload.length}");
    }

  } catch (e) {
    print("error: $e");
  }
}

extension Helpers on BytebeamSdk {
  void uploadMessage(StreamMessage message) {
    uploadMessageFfi(message: message.toFfi());
  }

  void uploadMessagesBatch(List<StreamMessage> messages) {
    uploadMessagesBatchFfi(
        messages: messages.map((m) => m.toFfi()).toList(growable: false)
    );
  }
}

Map<String, FieldValue> toFieldSet(Map<String, dynamic> fields) {
  Map<String, FieldValue> result = {};
  for (var it in fields.entries) {
    result[it.key] = convertToFieldValue(it.value);
  }
  return result;
}

FieldValue convertToFieldValue(dynamic value) {
  switch (value) {
    case null: return const FieldValue.null_();
    case String s: return FieldValue.string(s);
    case int i: return FieldValue.int(i);
    case bool b: return FieldValue.bool(b);
    case double d: return FieldValue.float(d);
    case List l: return FieldValue.array(
        l.map((e) => convertToFieldValue(e)
      ).toList()
    );
  }
  throw "value of type ${value.runtimeType} cannot be uploaded";
}
