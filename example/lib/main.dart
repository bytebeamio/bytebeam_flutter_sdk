import 'dart:async';
import 'package:flutter/material.dart';
import 'package:bytebeam_flutter/bytebeam_flutter.dart' as bytebeam;
import 'package:flutter/services.dart';

late bytebeam.BytebeamSdk sdk;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await bytebeam.initializeNativeCode();
  sdk = await bytebeam.BytebeamSdk.parse(creds: await rootBundle.loadString('assets/device.json'));
  Timer.periodic(Duration(seconds: 60), (timer) async {
    await sdk.uploadMessage(
        stream: "device_shadow",
        fields: {
          "uplink_version": "2.9.1"
        }
    );
  });
  runApp(const MaterialApp(home: UpdateScreen()));
}

enum UpdateStatus {
  idle,
  checking,
  updateAvailable,
  downloading,
  downloaded,
  installing,
  installed,
  error,
}

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({Key? key}) : super(key: key);

  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  UpdateStatus status = UpdateStatus.idle;
  bytebeam.AvailableUpdate? availableUpdate;
  int installationProgress = 0;
  String? errorMessage;
  String? infoMessage; // New variable for informational messages

  Future<void> _checkForUpdates() async {
    setState(() {
      status = UpdateStatus.checking;
      errorMessage = null;
      infoMessage = null; // Clear any previous message
    });

    try {
      final update = await sdk.fetchAvailableUpdate();
      setState(() {
        if (update != null) {
          availableUpdate = update;
          status = UpdateStatus.updateAvailable;
        } else {
          status = UpdateStatus.idle;
          infoMessage = "No updates available."; // Set the message
        }
      });
    } catch (e) {
      setState(() {
        status = UpdateStatus.error;
        errorMessage = e.toString();
      });
      if (availableUpdate != null) {
        await _sendStatusUpdate("error", 0, errors: [e.toString()]);
      }
    }
  }

  Future<void> _downloadUpdate() async {
    if (availableUpdate == null) return;

    setState(() {
      status = UpdateStatus.downloading;
    });

    await _sendStatusUpdate("downloading", 0);

    try {
      await sdk.downloadFirmware(url: availableUpdate!.params.url);
      setState(() {
        status = UpdateStatus.downloaded;
      });
      await _sendStatusUpdate("downloaded", 100);
    } catch (e) {
      setState(() {
        status = UpdateStatus.error;
        errorMessage = e.toString();
      });
      await _sendStatusUpdate("error", 0, errors: [e.toString()]);
    }
  }

  Future<void> _installUpdate() async {
    if (availableUpdate == null) return;

    setState(() {
      status = UpdateStatus.installing;
      installationProgress = 0;
    });

    await _sendStatusUpdate("installing", 0);

    try {
      for (int i = 1; i <= 10; i++) {
        await Future.delayed(const Duration(milliseconds: 50));
        setState(() {
          installationProgress = i * 10;
        });
        await _sendStatusUpdate("installing", i * 10);
      }
      setState(() {
        status = UpdateStatus.installed;
      });
      await _sendStatusUpdate("Completed", 100);
    } catch (e) {
      setState(() {
        status = UpdateStatus.error;
        errorMessage = e.toString();
      });
      await _sendStatusUpdate("error", installationProgress, errors: [e.toString()]);
    }
  }

  Future<void> _sendStatusUpdate(String state, int progress, {List<String>? errors}) async {
    if (availableUpdate == null) return;

    try {
      await sdk.uploadMessage(
        stream: "action_status",
        fields: {
          "action_id": availableUpdate!.actionId,
          "state": state,
          "progress": progress,
          "errors": errors ?? [],
        },
      );
    } catch (e) {
      print("Failed to send status update: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firmware Update Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: (status == UpdateStatus.checking ||
                    status == UpdateStatus.downloading ||
                    status == UpdateStatus.installing)
                    ? null
                    : _checkForUpdates,
                child: const Text('Check for Updates'),
              ),
              const SizedBox(height: 20),
              _buildStatusContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusContent() {
    switch (status) {
      case UpdateStatus.idle:
        return Text(infoMessage ?? 'Press the button to check for updates.');
      case UpdateStatus.checking:
        return const Text('Checking for updates...');
      case UpdateStatus.updateAvailable:
        if (availableUpdate != null) {
          return Column(
            children: [
              Text('Update Available: Version ${availableUpdate!.params.version}'),
              Text('Size: ${availableUpdate!.params.size} bytes'),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _downloadUpdate,
                child: const Text('Download Update'),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      case UpdateStatus.downloading:
        return const Text('Downloading firmware...');
      case UpdateStatus.downloaded:
        return Column(
          children: [
            const Text('Download complete!'),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _installUpdate,
              child: const Text('Install Update'),
            ),
          ],
        );
      case UpdateStatus.installing:
        return Text('Installing... $installationProgress%');
      case UpdateStatus.installed:
        return const Text('Installation complete!');
      case UpdateStatus.error:
        return Text(
          'Error: ${errorMessage ?? "An unknown error occurred"}',
          style: const TextStyle(color: Colors.red),
        );
    }
  }
}