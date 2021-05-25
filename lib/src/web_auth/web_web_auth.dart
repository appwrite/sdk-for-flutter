import 'web_auth.dart';

class FlutterWebAuthWeb extends FlutterWebAuth {
  @override
  Future<String> authenticate(
      {required String url, required String callbackUrlScheme}) {
    throw UnimplementedError();
  }
}

FlutterWebAuth getFlutterWebAuth() => FlutterWebAuthWeb();
