import 'dart:io';
import 'dart:math';

import 'package:bytebeam_flutter_sdk/lib.dart';
import 'package:bytebeam_flutter_sdk/messenger.dart';

Future<void> main(List<String> argv) async {
  late BytebeamClient client;
  var creds = await DeviceCredentials.fromFile(argv.elementAtOrNull(1) ?? "my.tmp.dir/cloud.json");
  client = await BytebeamClient.create(
      credentials: creds,
      enableMqttLogs: false, downloadFirmwares: true,
      actionsCallback: (action) {
        client.sendMessage(BytebeamPayload.actionResponse(action.id, "Installing", 50));
        print("received firmware: ${action.payload["firmware_path"]}");

        // install the firmware
        var installationSuccessful = Random().nextBool(); // just for demo

        // final status has to be one of `Failed` or `Completed`
        if (installationSuccessful) {
          client.sendMessage(BytebeamPayload.actionResponse(action.id, "Completed", 100));
        } else {
          client.sendMessage(BytebeamPayload.actionResponse(action.id, "Failed", 100));
        }
      }
  );
  await asleep(1000000);
}

Future<void> asleep(int seconds) async {
  await Future<void>.delayed(Duration(seconds: seconds));
}

