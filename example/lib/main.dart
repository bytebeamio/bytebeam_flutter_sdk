import 'dart:convert';
import 'dart:io';

import 'package:bytebeam_flutter/utils.dart';
import 'package:flutter/material.dart';
import 'package:bytebeam_flutter/bytebeam_flutter.dart' as bytebeam;
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bytebeam.initializeBytebeamClient(
    deviceShadowInterval: 1000,
    actionsCallback: (action) {
      var payload = jsonDecode(action.payload);
      var path = payload["download_path"];
      var size = File(path).lengthSync();

      print("received file of size: $size");
      bytebeam.sendMessage(bytebeam.actionResponse(
        actionId: action.actionId,
        status: "Working",
        progress: 33,
      ));
      bytebeam.sendMessage(bytebeam.actionResponse(
        actionId: action.actionId,
        status: "Installing",
        progress: 67,
      ));
      bytebeam.sendMessage(bytebeam.actionResponse(
        actionId: action.actionId,
        status: "Completed",
        progress: 100,
      ));
    },
    credentials: await rootBundle.loadString('assets/device.json'),
  );
  runApp(const MyApp());
}

var count = 0;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Bytebeam')),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                count++;
                String status = count % 2 == 0 ? "on" : "off";
                bytebeam.sendMessage(
                  bytebeam.BytebeamPayload(
                    stream: "test_stream",
                    sequence: count,
                    timestamp: clock(),
                    payload: {"status": bytebeam.FieldValue.string(status)},
                  ),
                );
              },
              child: Text("Push data"),
            ),
          ],
        ),
      ),
    );
  }
}
