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
  bytebeam.doStuff(await rootBundle.loadString('assets/device.json'));
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
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  // await connectToBytebeamBackend();
                },
                child: Text("Start"),
              ),
              ElevatedButton(
                onPressed: () {
                  // bytebeam.disconnectBytebeamClient();
                },
                child: Text("Stop"),
              ),
              ElevatedButton(
                onPressed: () {
                  count++;
                  String status = count % 2 == 0 ? "on" : "off";
                  // bytebeam.sendMessage(
                  //   bytebeam.BytebeamPayload(
                  //     stream: "test_stream",
                  //     sequence: count,
                  //     timestamp: clock(),
                  //     payload: {"status": bytebeam.FieldValue.string(status)},
                  //   ),
                  // );
                },
                child: Text("Push data"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
