# Bytebeam Flutter Sdk

SDK for communicating with the bytebeam cloud from a flutter app. See example app for usage instructions.

## API

* `void initializeNativeCode()`
Must be called when the application boots up.

## `BytebeamSdk` class

This class has the following methods:

* `static Future<BytebeamSdk> parse({required String creds})`
Parse and validate a credentials string you receive when provisioning a device on our platform.

* `Future<AvailableUpdate?> fetchAvailableUpdate()`
Fetch current update. Returns null if no update is available.

* `Future<Uint8List> downloadFirmware({required String url})`
Takes the url of an update returned from `fetchAvailableUpdate` and securely downloads it.

* `Future<void> uploadMessage({required String stream, required Map<String, dynamic> fields})`
Upload a message to a stream. 
When responding to actions, you need to send a message to the `action_status` stream with fields 
(`action_id`, `state`, `progress`, and `errors` (optional))
