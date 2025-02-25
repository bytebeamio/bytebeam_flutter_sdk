# Bytebeam Flutter Sdk

SDK for communicating with the bytebeam cloud from a flutter app. See example app for usage instructions.

## API

* `void initializeNativeCode()`
Must be called when the application boots up.

* `void initializeBytebeamClient`
Initiate connection to the backend using this configuration. The SDK manages a global connection and the old one is terminated if this function is called again.
You can pass a callback that will be invoked for incoming actions.

* `bool sdkInitialized()`
Status of the global connection

* `void disconnectBytebeamClient()`
Dispose the existing connection to bytebeam backend

* `sendMessage`
Send a message to the bytebeam cloud using the global connection. If responding to incoming actions.

* `actionResponse`
A utility function you can use to create a payload that you can pass to `sendMessage`.