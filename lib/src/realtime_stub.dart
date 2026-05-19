import 'realtime_base.dart';
import 'client.dart';

/// Implemented in `realtime_browser.dart` and `realtime_io.dart`.
RealtimeBase createRealtime(ClientAuth client) => throw UnsupportedError(
  'Cannot create a client without dart:html or dart:io.',
);
