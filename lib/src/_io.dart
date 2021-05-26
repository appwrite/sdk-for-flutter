import 'package:flutter_web_auth/flutter_web_auth.dart' as webauth;
import 'package:path_provider/path_provider.dart' as path;


Future getApplicationDocumentsDirectory() => path.getApplicationDocumentsDirectory();


Future<String> oauthAuthenticate(
        {required String url, required String callbackUrlScheme}) =>
    webauth.FlutterWebAuth.authenticate(
        url: url, callbackUrlScheme: callbackUrlScheme);
