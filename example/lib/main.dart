import 'package:bytebeam_flutter_sdk/lib.dart';
import 'package:flutter/material.dart';

Future<void> main(List<String> argv) async {
  var creds = await DeviceCredentials.fromFile(argv.elementAtOrNull(1) ?? "my.tmp.dir/stage_new_1.json");
  var client = await BytebeamClient.create(credentials: creds, enableMqttLogs: false, downloadFirmwares: true, actionsCallback: (action) {});
  await asleep(1000000);
}

Future<void> asleep(int seconds) async {
  await Future<void>.delayed(Duration(seconds: seconds));
}

