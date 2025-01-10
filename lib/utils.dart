
import 'dart:io';

int clock() {
  return DateTime.now().millisecondsSinceEpoch;
}

Future<void> ensureExists(String directory) async {
  var d = Directory(directory);
  if (! await d.exists()) {
    await d.create(recursive: true);
  }
}


T dbg<T>(T value) {
  print(value);
  return value;
}