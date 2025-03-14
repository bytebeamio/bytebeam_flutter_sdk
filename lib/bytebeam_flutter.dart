library;

import 'package:bytebeam_flutter/src/rust/api.dart';
export 'package:bytebeam_flutter/src/rust/api.dart';
import 'src/rust/frb_generated.dart' show RustLib;

Future<void> initializeNativeCode() async {
  try {
    await RustLib.init();
  } catch (e) {
    print(e);
  }
}

Future<void> doStuff(String token) async {
  try {
    print("step 1");
    var sdk = await BytebeamSdk.parse(creds: token);
    print("step 2");
    var update = await sdk.fetchAvailableUpdate();
    print("update: ${update?.params.url} | ${update?.actionId}");
    if (update != null) {
      print("step 3");
      var payload = await sdk.downloadFirmware(url: update.params.url);
      print("received firmware of size: ${payload.length}");
    }
    print("step 4");
    await sdk.uploadMessage(
      stream: "device_shadow",
      fields: {
        "nf": 1.2
      }
    );
    print("dan");
  } catch (e) {
    print("error: $e");
  }
}

extension Helpers on BytebeamSdk {
  Future<void> uploadMessage(
      {required String stream,
      required Map<String, dynamic> fields,
      int sequence = 0,
      DateTime? timestamp}) {
    return uploadMessagesBatchFfi(
      stream: stream,
      messages: [
        StreamMessageFfi(
            sequence: sequence,
            timestamp: BigInt.from(
                (timestamp ?? DateTime.now()).millisecondsSinceEpoch),
            fields: toFieldSet(fields))
      ],
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
    case null:
      return const FieldValue.null_();
    case String s:
      return FieldValue.string(s);
    case int i:
      return FieldValue.int(i);
    case bool b:
      return FieldValue.bool(b);
    case double d:
      return FieldValue.float(d);
    case List l:
      return FieldValue.array(l.map((e) => convertToFieldValue(e)).toList());
  }
  throw "value of type ${value.runtimeType} cannot be uploaded";
}
