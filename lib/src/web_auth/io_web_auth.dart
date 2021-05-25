import 'package:appwrite/src/web_auth/web_auth.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart' as webauth;

class FlutterWebAuthIO extends FlutterWebAuth {
  @override
  Future<String> authenticate(
      {required String url, required String callbackUrlScheme}) {
    return webauth.FlutterWebAuth.authenticate(
        url: url, callbackUrlScheme: callbackUrlScheme);
  }
}

FlutterWebAuth getFlutterWebAuth() => FlutterWebAuthIO();
