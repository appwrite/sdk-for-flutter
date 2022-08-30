import 'client_base.dart';

/// Implemented in `client_browser.dart` and `client_io.dart`.
ClientBase createClient({required String endPoint, required bool selfSigned}) =>
    throw UnsupportedError(
        'Cannot create a client without dart:html or dart:io.');
