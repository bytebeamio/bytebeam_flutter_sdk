import "dart:convert";
import "dart:io";

import "package:bytebeam_flutter_sdk/utils.dart";
import "package:http/http.dart";
import "package:http/io_client.dart";

class DeviceCredentials {
  String id;
  String project;
  String brokerHost;
  int brokerPort;
  String caCertificate;
  String deviceCertificate;
  String devicePrivateKey;

  DeviceCredentials({
    required this.id,
    required this.project,
    required this.brokerHost,
    required this.brokerPort,
    required this.caCertificate,
    required this.deviceCertificate,
    required this.devicePrivateKey,
  });

  static DeviceCredentials fromString(String jsonString) {
    final Map<String, dynamic> jsonMap = json.decode(jsonString);

    var auth = jsonMap["authentication"] as Map;
    return DeviceCredentials(
      id: jsonMap["device_id"] as String,
      project: jsonMap["project_id"] as String,
      brokerHost: jsonMap["broker"] as String,
      brokerPort: jsonMap["port"] as int,
      caCertificate: auth["ca_certificate"] as String,
      deviceCertificate: auth["device_certificate"] as String,
      devicePrivateKey: auth["device_private_key"] as String,
    );
  }

  static Future<DeviceCredentials> fromFile(String path) async {
    return DeviceCredentials.fromString(await File(path).readAsString());
  }

  SecurityContext createSecurityContext() {
    var result = SecurityContext();
    result.setTrustedCertificatesBytes(caCertificate.codeUnits);
    result.useCertificateChainBytes(deviceCertificate.codeUnits);
    result.usePrivateKeyBytes(devicePrivateKey.codeUnits);
    return result;
  }

  BaseClient httpClient() {
    final HttpClient httpClient = HttpClient(context: createSecurityContext());
    return IOClient(httpClient);
  }
}

class Action {
  String name;
  String id;
  Map<String, dynamic> payload;
  Action(this.name, this.id, this.payload);

  static Action fromString(String input) {
    final Map<String, dynamic> jsonMap = json.decode(input);
    return Action(
      jsonMap["name"] as String,
      jsonMap["id"] as String,
      json.decode(jsonMap["payload"] as String),
    );
  }
}

class BytebeamPayload {
  String stream;
  int sequence;
  int timestamp = clock();
  Map<String, dynamic> fields;

  BytebeamPayload(this.stream, this.sequence, this.fields);

  static BytebeamPayload actionResponse(String action_id, String status, int progress, {String? error}) {
    var fields = <String, dynamic>{};
    fields["action_id"] = action_id;
    fields["status"] = status;
    fields["progress"] = progress;
    if (error != null) {
      fields["errors"] = [error];
    }
    return BytebeamPayload("action_status", 0, fields);
  }

  String toPayloadItem() {
    Map<String, dynamic> jsonMap = {
      'sequence': sequence,
      'timestamp': timestamp,
    };
    jsonMap.addAll(fields);

    return jsonEncode(jsonMap);
  }
}

