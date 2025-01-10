
import 'dart:collection';

import 'package:bytebeam_flutter_sdk/lib.dart';
import 'package:mqtt_client/mqtt_client.dart';

extension Messenger on BytebeamClient {

  /// Queue a message to be uploaded to cloud
  void sendMessage(BytebeamPayload payload) {
    if (messagesQueue.length >= maxQueuedMessages) {
      messagesQueue.removeFirst();
    }
    messagesQueue.addLast(payload);
  }

  /// Internal
  Future<void> messengerTask() async {
    try {
      while (isConnected()) {
        var payload = messagesQueue.firstOrNull;
        if (payload == null) {
          await MqttUtilities.asyncSleep(1);
        } else {
          var mqttMessage = MqttClientPayloadBuilder();
          var message = payload.asMqttPayload();
          String topic;
          if (payload.stream == "action_status") {
            topic = "/tenants/${credentials.project}/devices/${credentials.deviceId}/action/status";
          } else {
            topic = "/tenants/${credentials.project}/devices/${credentials.deviceId}/events/${payload.stream}/jsonarray";
          }
          mqttMessage.addString(message);
          mqttClient.publishMessage(topic, MqttQos.atLeastOnce, mqttMessage.payload!);
          messagesQueue.removeFirst();
        }
      }
    } catch (e) {
      if (isConnected()) {
        print("BYTEBEAM::ERROR messenger task ended with error: $e");
      }
    }
  }

  /// Internal
  Future<void> deviceShadowTask() async {
    int sequence = 1;
    try {
      while (isConnected()) {
        sendMessage(BytebeamPayload("device_shadow", sequence, {}));
        sequence += 1;
        await MqttUtilities.asyncSleep(15);
      }
    } catch (e) {
      if (isConnected()) {
        print("BYTEBEAM::ERROR device shadow task ended with error: $e");
      }
    }
  }

  bool isConnected() {
    return connectionState == ConnectionState.Connected;
  }
}