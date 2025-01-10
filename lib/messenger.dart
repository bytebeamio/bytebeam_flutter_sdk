
import 'dart:collection';

import 'package:bytebeam_flutter_sdk/lib.dart';
import 'package:mqtt_client/mqtt_client.dart';

extension Messenger on BytebeamClient {
  void sendMessage(BytebeamPayload payload) {
    messagesQueue.addLast(payload);
  }

  Future<void> uploadTask() async {
    while (!disconnected) {
      var next = messagesQueue.firstOrNull;
      if (next == null) {
        MqttUtilities.asyncSleep(1);
      } else {
        // var topic = "/tenants/${credentials.project}/devices/${credentials.id}/events/${next.stream}/jsonarray";
        // var mqttMessage = MqttClientPayloadBuilder();
        // mqttClient.publishMessage(topic, MqttQos.atLeastOnce, );
      }
    }
  }
}