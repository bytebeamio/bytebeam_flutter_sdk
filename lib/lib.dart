import 'dart:collection';
import 'dart:convert';

import 'package:bytebeam_flutter_sdk/types.dart';
import 'package:bytebeam_flutter_sdk/downloader.dart';
import 'package:bytebeam_flutter_sdk/messenger.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

export 'package:bytebeam_flutter_sdk/types.dart';

class BytebeamClient {
  DeviceCredentials credentials;
  MqttServerClient mqttClient;
  bool disconnected = false;
  bool downloadFirmwares;
  int maxQueuedMessages;
  Queue<BytebeamPayload> messagesQueue = Queue();
  void Function(Action action) sendActionToUser;

  BytebeamClient._(this.credentials, this.mqttClient, this.downloadFirmwares, bool sendDeviceShadow, this.maxQueuedMessages, this.sendActionToUser) {
    mqttClient.updates!.listen((events) async {
      for (var event in events) {
        if (event.payload is MqttPublishMessage) {
          var pub = event.payload as MqttPublishMessage;
          var action = Action.fromString(utf8.decode(pub.payload.message));
          processAction(action);
        }
      }
    });

    mqttClient.published!.listen((message) {
      // TODO: what comes here?
      // pubacks
      // print("BYTEBEAM::INFO puback: $message");
    });

    if (sendDeviceShadow) {
      deviceShadowTask();
    }
    messengerTask();
  }

  /// Connect to bytebeam backend
  /// `credentials` : Device credentials provisioned by bytebeam
  /// `actionsCallback` : A callback to handle actions sent to this device
  /// `downloadFirmwares` : Intercept actions of type "update_firmware", download them from
  /// the bytebeam backend, and add their path to the action payload before forwarding to `actionsCallback`. (See example application)
  /// `enableMqttLogs` : Enable low level mqtt client logs
  /// `maxQueuedMessages` : If network is down, this library will buffer outgoing messages in memory. This parameter can be used to control the max buffer size
  /// `sendDeviceShadow` : Automatically send messages to "device_shadow" stream. This is used to show the device heartbeat on the dashboard.
  ///
  /// It will throw an exception if network is down
  /// Afterwards, it will reconnect in case of disconnections automatically
  static Future<BytebeamClient> create({
    required DeviceCredentials credentials,
    required void Function(Action) actionsCallback,
    bool downloadFirmwares = true,
    bool enableMqttLogs = false,
    int maxQueuedMessages = 1024,
    bool sendDeviceShadow = true,
  }) async {
    var client = MqttServerClient(credentials.brokerHost, credentials.deviceId);
    client.logging(on: enableMqttLogs);
    client.port = credentials.brokerPort;
    client.setProtocolV311();

    client.secure = true;
    client.securityContext = credentials.createSecurityContext();

    client.keepAlivePeriod = 30;
    client.autoReconnect = true;

    try {
      // TODO: test how autoReconnect works with initial connection
      await client.connect();
    } catch (e) {
      print("BYTEBEAM::ERROR failed to connect to broker");
      client.disconnect();
      rethrow;
    }

    if (client.connectionStatus?.state == MqttConnectionState.connected) {
      print("BYTEBEAM::INFO connected to bytebeam broker");
    } else {
      throw "failed to connect to broker, mqtt response: ${client.connectionStatus?.returnCode}";
    }

    var actionsTopic = "/tenants/${credentials.project}/devices/${credentials.deviceId}/actions";
    client.subscribe(actionsTopic, MqttQos.atLeastOnce);

    return BytebeamClient._(credentials, client, downloadFirmwares, sendDeviceShadow, maxQueuedMessages, actionsCallback);
  }

  /// Disconnect from broker and stop all background threads.
  void disconnect() {
    mqttClient.disconnect();
    disconnected = true;
  }

  Future<void> processAction(Action action) async {
    print("BYTEBEAM::INFO received action: ${action.name}, ${action.id}, ${action.payload}");
    if (downloadFirmwares && action.name == "update_firmware") {
      try {
        performDownload(action);
      } catch (e) {
        var error = "download failed: $e";
        print("BYTEBEAM::ERROR $error");
        sendMessage(BytebeamPayload.actionResponse(action.id, "Failed", 100, error: error) );
      }
    } else {
      // send to user
      sendActionToUser(action);
    }
  }
}
