import 'dart:io';

import 'package:path_provider/path_provider.dart';

// Next to the client's cookie store, so a reinstall or "clear data" removes both.
Future<File> _file(String name) async {
  final dir = await getApplicationDocumentsDirectory();
  return File('${dir.path}/appwrite_tracking_$name');
}

Future<File> _markerFile() => _file('install');

/// The app version saved by the last start, or null when this install has no marker yet.
Future<String?> readInstallMarker() async {
  final file = await _markerFile();
  return await file.exists() ? file.readAsString() : null;
}

/// Whether the client has saved cookies before, i.e. an install that ran an SDK release
/// without the marker.
Future<bool> sdkRanBefore() async {
  final dir = await getApplicationDocumentsDirectory();
  final cookies = Directory('${dir.path}/cookies');
  return await cookies.exists() &&
      await cookies.list(recursive: true).any((entry) => entry is File);
}

Future<void> writeInstallMarker(String version) async {
  await (await _markerFile()).writeAsString(version, flush: true);
}

/// The install event (`{"name", "props"}` JSON) saved until it is sent, or null.
Future<String?> readPendingInstallEvent() async {
  final file = await _file('pending');
  return await file.exists() ? file.readAsString() : null;
}

/// Save [json] as the pending install event, or clear it when null.
Future<void> writePendingInstallEvent(String? json) async {
  final file = await _file('pending');
  if (json == null) {
    if (await file.exists()) {
      await file.delete();
    }
    return;
  }
  await file.writeAsString(json, flush: true);
}
