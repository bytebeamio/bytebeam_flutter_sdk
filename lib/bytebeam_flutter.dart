library;

import 'dart:convert';

import 'package:bytebeam_flutter/utils.dart';
import 'package:path_provider/path_provider.dart';

export 'src/rust/api/types.dart';
import 'src/rust/api/types.dart';

import 'src/rust/frb_generated.dart' show RustLib;
export 'src/rust/frb_generated.dart' show RustLib;

Future<void> initializeBytebeamClient({
  required String credentials,
  required void Function(Action) actionsCallback,
  bool downloadFirmwares = true,
  bool enableMqttLogs = false,
  int deviceShadowInterval = 10,
}) async {
  try {
    await RustLib.init();
  } catch (_e) {}
  var persistenceConfig =
      "persistence_path = \"${(await getApplicationSupportDirectory()).path}/bytebeam/persistence\"";
  var actionRedirections = downloadFirmwares
      ? "action_redirections = { \"update_firmware\" = \"install_update\" }"
      : "";
  var downloaderConfig = downloadFirmwares
      ? "[downloader]\n"
          "actions = [{ name = \"update_firmware\" }]\n"
          "path = \"${(await getApplicationSupportDirectory()).path}/bytebeam/downloads\""
      : "";
  var deviceShadowConfig = "[device_shadow]\n"
      "interval = $deviceShadowInterval";

  // language=toml
  var defaultConfig = """
  [system_stats]
  enabled = false
  
  [serializer_metrics]
  enabled = false
  
  [stream_metrics]
  enabled = false
  
  [mqtt_metrics]
  enabled = false
  
  [streams.test_stream]
  batch_size = 1
  """;

  var nativeLogs = RustLib.instance.api.crateApiLoggerSetupLogs();
  nativeLogs.handleError((e) {
    print("Failed to set up native logs: $e");
  }).listen((logRow) {
    print("[native] $logRow");
  });

  RustLib.instance.api.crateApiInitializeBytebeamSdk(
      deviceJson: credentials,
      configToml:
          "$persistenceConfig\n$actionRedirections\n$downloaderConfig\n$deviceShadowConfig\n$defaultConfig\n",
      actionsCallback: (action) {
        actionsCallback(action);
      });
}

void sendMessage(BytebeamPayload payload) {
  RustLib.instance.api.crateApiSendMessage(payload: payload);
}

BytebeamPayload actionResponse({
  int sequence = 0,
  BigInt? timestamp,
  required String actionId,
  required String status,
  required int progress,
  String? error,
}) {
  var payload = {
    "action_id": FieldValue.string(actionId),
    "state": FieldValue.string(status),
    "progress": FieldValue.int(progress),
  };
  if (error != null) {
    payload["errors"] = FieldValue.array([FieldValue.string(error)]);
  }
  return BytebeamPayload(
    stream: "action_status",
    sequence: sequence,
    timestamp: timestamp ?? clock(),
    payload: payload,
  );
}
