library;

import 'package:bytebeam_flutter/utils.dart';
import 'package:path_provider/path_provider.dart';

export 'src/rust/api/types.dart';
import 'src/rust/api/types.dart';

import 'src/rust/frb_generated.dart' show RustLib;

Future<void> initializeNativeCode() async {
  try {
    await RustLib.init();
  } catch (_e) {}
}

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
  bool enableRemoteShell = false,
  /// interval in seconds at which device_shadow ping should be sent
  int deviceShadowInterval = 10,
}) async {
  var actionRedirections = downloadFirmwares
      ? "action_redirections = { \"update_firmware\" = \"install_update\" }"
      : "";
  var downloaderConfig = downloadFirmwares
      ? "[downloader]\n"
      "actions = [{ name = \"update_firmware\" }]\n"
      "path = \"${(await getApplicationSupportDirectory()).path}/bytebeam/downloads\""
      : "";
  var deviceShadowConfig = "[device_shadow]\n"
      "enabled = true\n"
      "interval = $deviceShadowInterval";

  var uplinkConfig = """
  enable_remote_shell = $enableRemoteShell
  persistence_path = "${(await getApplicationSupportDirectory()).path}/bytebeam/persistence"
  
  $actionRedirections
  
  $downloaderConfig
  
  $deviceShadowConfig
  
  [system_stats]
  enabled = false
  
  [serializer_metrics]
  enabled = false
  
  [stream_metrics]
  enabled = false
  
  [mqtt_metrics]
  enabled = false
  
  [streams.test_stream]
  flush_period = 10
  """;

  var nativeLogs = RustLib.instance.api.crateApiLoggerSetupLogs();
  nativeLogs.handleError((e) {
    print("Failed to set up native logs: $e");
  }).listen((logRow) {
    print("[native] $logRow");
  });

  RustLib.instance.api.crateApiInitializeBytebeamSdk(
      deviceJson: credentials,
      configToml: uplinkConfig,
      actionsCallback: (action) {
        actionsCallback(action);
      });
}

/// disconnect from bytebeam backend
void disconnectBytebeamClient() {
  RustLib.instance.api.crateApiDisconnectBytebeamClient();
}

bool sdkInitialized() {
  return RustLib.instance.api.crateApiSdkInitialized();
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
