library;

import 'package:bytebeam_flutter/src/rust/api.dart';

export 'src/rust/api/types.dart';

import 'src/rust/frb_generated.dart' show RustLib;

Future<void> initializeNativeCode() async {
  try {
    await RustLib.init();
  } catch (e) {
    print(e);
  }
  // try {
  //   print("setting up logger");
  //   var nativeLogs = RustLib.instance.api.crateApiLoggerSetupLogs();
  //   nativeLogs.handleError((e) {
  //     print("Failed to set up native logs: $e");
  //   }).listen((logRow) {
  //     print("[native] $logRow");
  //   });
  // } catch (e) {
  //   print(e);
  // }
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
