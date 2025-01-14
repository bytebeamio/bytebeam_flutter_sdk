
import 'dart:io';

import 'package:bytebeam_flutter_sdk/messenger.dart';
import 'package:http/http.dart' as http;
import 'package:bytebeam_flutter_sdk/lib.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart' as uuid;

extension Downloader on BytebeamClient {
  Future<void> performDownload(Action action) async {
    var url = action.payload["url"] as String;

    var asDirectory = await getApplicationSupportDirectory();
    var downloadDirectory = p.join(asDirectory.path, "bytebeam_downloads");
    var filePath = p.join(downloadDirectory, uuid.Uuid().v4());
    var downloadFile = File(filePath);
    await downloadFile.create(recursive: true);
    try {
      var fileWriter = await downloadFile.open(mode: FileMode.write);
      await fileWriter.truncate(0);

      var response = await credentials.httpClient()
          .send(http.Request("GET", Uri.parse(url)));
      if (response.statusCode != 200) {
        throw "http status code: ${response.statusCode}";
      }

      var contentLength = response.contentLength;
      var written = 0;
      await for (var chunk in response.stream) {
        await fileWriter.writeFrom(chunk);
        written += chunk.length;
        int progress;
        String? error;
        if (contentLength == null) {
          progress = 0;
          error = "content-length not available";
        } else {
          progress = ((written / contentLength) * 100).toInt();
          error = null;
        }
        sendMessage(BytebeamPayload.actionResponse(action.id, "Downloading", progress, error: error));
      }
      sendMessage(BytebeamPayload.actionResponse(action.id, "Downloaded", 100));
      action.payload["firmware_path"] = filePath;
      try { sendActionToUser(action); } catch (e) {}
    } catch (e) {
      await downloadFile.delete();
      rethrow;
    }
  }
}