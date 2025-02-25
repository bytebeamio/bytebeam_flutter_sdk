import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bytebeam_flutter/utils.dart';
import 'package:flutter/material.dart';
import 'package:bytebeam_flutter/bytebeam_flutter.dart' as bytebeam;
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await bytebeam.initializeNativeCode();
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
            BytebeamSDKStatus(),
            ElevatedButton(
              onPressed: () async {
                await connectToBytebeamBackend();
              },
              child: Text("Start"),
            ),
            ElevatedButton(
              onPressed: () {
                bytebeam.disconnectBytebeamClient();
              },
              child: Text("Stop"),
            ),
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

Future<void> connectToBytebeamBackend() async {
  bytebeam.initializeBytebeamClient(
      deviceShadowInterval: 30,
      actionsCallback: (action) {
        if (action.name == "install_update") {
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
        } else {
          bytebeam.sendMessage(bytebeam.actionResponse(
              actionId: action.actionId,
              status: "Failed",
              progress: 100,
              error: "unsupported action type: ${action.name}"
          ));
        }
      },
      credentials: await rootBundle.loadString('assets/device.json'),
  );
}

class BytebeamSDKStatus extends StatefulWidget {
  final Duration interval;

  const BytebeamSDKStatus({
    super.key,
    this.interval = const Duration(seconds: 1),
  });

  @override
  State<BytebeamSDKStatus> createState() => _BytebeamSDKStatusState();
}

class _BytebeamSDKStatusState extends State<BytebeamSDKStatus> {
  bool result = false;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(widget.interval, (_) async {
      final value = bytebeam.sdkInitialized();
      if (mounted) {
        setState(() => result = value);
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        result ? 'running' : 'stopped',
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
