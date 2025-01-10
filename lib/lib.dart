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
  ConnectionState connectionState = ConnectionState.Init;

  bool downloadFirmwares;
  bool sendDeviceShadow;
  int maxQueuedMessages;
  Queue<BytebeamPayload> messagesQueue = Queue();
  void Function(Action action) sendActionToUser;

  BytebeamClient._(this.credentials, this.mqttClient, this.downloadFirmwares, this.sendDeviceShadow, this.maxQueuedMessages, this.sendActionToUser) {
    initiateConnection();
  }

  /// Connect to bytebeam backend
  /// `credentials` : Device credentials provisioned by bytebeam
  /// `actionsCallback` : A callback to handle actions sent to this device
  /// `downloadFirmwares` : Intercept actions of type "update_firmware", download them from
  /// the bytebeam backend, and add their path to the action payload before forwarding to `actionsCallback`. (See example application)
  /// `enableMqttLogs` : Enable low level mqtt client logs
  /// `maxQueuedMessages` : If network is down, this library will buffer outgoing messages in memory. This parameter can be used to control the max buffer size
  /// `sendDeviceShadow` : Automatically send messages to "device_shadow" stream. This is used to show the device heartbeat on the dashboard.
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

    return BytebeamClient._(credentials, client, downloadFirmwares, sendDeviceShadow, maxQueuedMessages, actionsCallback);
  }

  /// Disconnect from broker and stop all background threads.
  void disconnect() {
    mqttClient.disconnect();
    connectionState = ConnectionState.Disconnected;
  }

  Future<void> processAction(Action action) async {
    print("BYTEBEAM::INFO received action: ${action.name}, ${action.id}, ${action.payload}");
    sendMessage(BytebeamPayload.actionResponse(action.id, "ReceivedByDevice", 0));
    if (downloadFirmwares && action.name == "update_firmware") {
      try {
        performDownload(action);
      } catch (e) {
        var error = "download failed: $e";
        print("BYTEBEAM::ERROR $error");
        sendMessage(BytebeamPayload.actionResponse(action.id, "Failed", 100, error: error) );
      }
    } else {
      try { sendActionToUser(action); } catch (e) {}
    }
  }

  Future<void> initiateConnection() async {
    while (true) {
      try {
        await mqttClient.connect();
        connectionState = ConnectionState.Connected;
        print("BYTEBEAM::INFO connected to bytebeam broker");
        break;
      } catch (e) {
        print("BYTEBEAM::WARN couldn't connect, network is down. retrying in 3s");
        await MqttUtilities.asyncSleep(3);
      }
    }

    mqttClient.updates!.listen((events) async {
      for (var event in events) {
        if (event.payload is MqttPublishMessage) {
          var pub = event.payload as MqttPublishMessage;
          var action = Action.fromString(utf8.decode(pub.payload.message));
          processAction(action);
        }
      }
    });
    mqttClient.published!.listen((message) {});

    var actionsTopic = "/tenants/${credentials.project}/devices/${credentials.deviceId}/actions";
    mqttClient.subscribe(actionsTopic, MqttQos.atLeastOnce);

    if (sendDeviceShadow) {
      deviceShadowTask();
    }
    messengerTask();
  }
}

enum ConnectionState {
  Init,
  Connected,
  Disconnected,
}