import 'dart:io';
import 'dart:convert';

BigInt clock() {
  return BigInt.from(DateTime.now().millisecondsSinceEpoch);
}

Future<void> ensureExists(String directory) async {
  var d = Directory(directory);
  if (!await d.exists()) {
    await d.create(recursive: true);
  }
}

T dbg<T>(T value) {
  print(value);
  return value;
}

List<int> pemToDer(String pem) {
  final pemLines = pem.split('\n');
  final base64Cert = pemLines.where((line) => !line.startsWith('-----')).join();
  final result = base64Decode(base64Cert);
  return result;
}
