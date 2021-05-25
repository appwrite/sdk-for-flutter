import 'web_auth_stub.dart'
    if (dart.library.io) 'io_web_auth.dart'
    if (dart.library.js) 'web_web_auth.dart';

abstract class FlutterWebAuth {
  static FlutterWebAuth? _instance;
  static FlutterWebAuth get instance {
    _instance ??= getFlutterWebAuth();
    return _instance!;
  }

  Future<String> authenticate(
      {required String url, required String callbackUrlScheme});
}
