library;

import 'package:bytebeam_flutter/utils.dart';
import 'package:path_provider/path_provider.dart';

export 'src/rust/api/types.dart';
import 'src/rust/api/types.dart';

import 'src/rust/frb_generated.dart' show RustLib;
export 'src/rust/frb_generated.dart' show RustLib;

/// Initiate connection to the backend using this configuration
/// The SDK manages a global connection and the old one is terminated
/// if this function is called again
Future<void> initializeBytebeamClient({
  /// Bytebeam device credentials
  required String credentials,
  /// callback that will be invoked for incoming actions
  required void Function(Action) actionsCallback,
  /// whether the sdk should download firmwares in advance
  bool downloadFirmwares = true,
  /// interval in seconds at which device_shadow ping should be sent
  int deviceShadowInterval = 10,
  /// extra stuff that you might want to put in uplink config file
  String extraConfig = "",
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

/// Send a message to the bytebeam cloud
void sendMessage(BytebeamPayload payload) {
  try {
    RustLib.instance.api.crateApiSendMessage(payload: payload);
  } catch (e) {
    print("BYTEBEAM::ERROR attempted to send a message before initializing the connection");
  }
}

/// Create an action response message that can be sent to the bytebeam cloud
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
