/// Implemented in `tracking_install_io.dart`. Without dart:io (the web) there is no
/// install to mark, so [Tracking] never sends `first_open` or `app_updated` there.
Future<String?> readInstallMarker() async => null;

Future<bool> sdkRanBefore() async => true;

Future<void> writeInstallMarker(String version) async {}

Future<String?> readPendingInstallEvent() async => null;

Future<void> writePendingInstallEvent(String? json) async {}
