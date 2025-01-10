import 'package:bytebeam_flutter_sdk/lib.dart';

Future<void> main(List<String> argv) async {
  var creds = await DeviceCredentials.fromFile(argv.elementAtOrNull(1) ?? "my.tmp.dir/cloud.json");
  var client = await BytebeamClient.create(
      credentials: creds,
      enableMqttLogs: false, downloadFirmwares: true,
      actionsCallback: (action) {
        print("client received an action: $action");
      }
  );
  await asleep(1000000);
}

Future<void> asleep(int seconds) async {
  await Future<void>.delayed(Duration(seconds: seconds));
}

