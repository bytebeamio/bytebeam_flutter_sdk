import 'dart:async';

import 'package:flutter/material.dart';
import 'package:bytebeam_flutter/bytebeam_flutter.dart' as bytebeam;
import 'package:flutter/services.dart';

late bytebeam.BytebeamSdk sdk;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await bytebeam.initializeNativeCode();
  sdk = await bytebeam.BytebeamSdk.parse(creds: await rootBundle.loadString('assets/device.json'));
  runApp(const MyApp());
}

var count = 0;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  OTAState state = OTAState.Idle;
  bool update_available = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Bytebeam')),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                },
                child: Text("Check for update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum OTAState {
  Idle,
  UpdateNotAvailable,
  CheckingForUpdate,
  UpdateAvailable,
  DownloadingUpdate,
  Downloaded,
  InstallingUpdate,
}