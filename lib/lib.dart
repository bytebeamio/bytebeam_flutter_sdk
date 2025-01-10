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
  Queue<BytebeamPayload> messagesQueue = Queue();
  void Function(Action action) sendActionToUser;

  BytebeamClient._(this.credentials, this.mqttClient, this.downloadFirmwares, this.sendActionToUser) {
    mqttClient.updates!.listen((events) async {
      print("BYTEBEAM::INFO incoming publishes:");
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
  }

  static Future<BytebeamClient> create({
    required DeviceCredentials credentials,
    required void Function(Action) actionsCallback,
    bool downloadFirmwares = true,
    bool enableMqttLogs = false,
  }) async {
    var client = MqttServerClient(credentials.brokerHost, credentials.id);
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
      print("BYTEBEAM::ERROR failed to connect to broker, mqtt response: ${client.connectionStatus?.returnCode}");
    }

    var actionsTopic = "/tenants/${credentials.project}/devices/${credentials.id}/actions";
    client.subscribe(actionsTopic, MqttQos.atLeastOnce);

    return BytebeamClient._(credentials, client, downloadFirmwares, actionsCallback);
  }

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
