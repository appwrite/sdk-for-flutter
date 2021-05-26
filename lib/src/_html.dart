import 'dart:html' as html;

Future<String> oauthAuthenticate(
    {required String url, required String callbackUrlScheme}) {
  html.window.location.href = url.toString();
  return Future.value("");
}

Future getApplicationDocumentsDirectory() =>
    throw UnsupportedError('cannot create a path provider');