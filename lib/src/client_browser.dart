import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'package:http/browser_client.dart';
import 'client_mixin.dart';
import 'enums.dart';
import 'exception.dart';
import 'client_base.dart';

import 'response.dart';

ClientBase createClient({
  required String endPoint,
  required bool selfSigned,
}) =>
    ClientBrowser(endPoint: endPoint, selfSigned: selfSigned);

class ClientBrowser extends ClientBase with ClientMixin {
  String _endPoint;
  Map<String, String>? _headers;
  late Map<String, String> config;
  late BrowserClient _httpClient;
  String? _endPointRealtime;

  String? get endPointRealtime => _endPointRealtime;

  ClientBrowser({
    String endPoint = 'https://appwrite.io/v1',
    bool selfSigned = false,
  }) : _endPoint = endPoint {
    _httpClient = BrowserClient();
    _endPointRealtime = endPoint
        .replaceFirst('https://', 'wss://')
        .replaceFirst('http://', 'ws://');
    _headers = {
      'content-type': 'application/json',
      'x-sdk-version': 'appwrite:flutter:1.0.1',
      'X-Appwrite-Response-Format' : '0.10.0',
    };

    this.config = {};

    assert(_endPoint.startsWith(RegExp("http://|https://")),
        "endPoint $_endPoint must start with 'http'");
    init();
  }

  String get endPoint => _endPoint;

     /// Your project ID
    ClientBrowser setProject(value) {
        config['project'] = value;
        addHeader('X-Appwrite-Project', value);
        return this;
    }
     /// Your secret JSON Web Token
    ClientBrowser setJWT(value) {
        config['jWT'] = value;
        addHeader('X-Appwrite-JWT', value);
        return this;
    }
    ClientBrowser setLocale(value) {
        config['locale'] = value;
        addHeader('X-Appwrite-Locale', value);
        return this;
    }

  ClientBrowser setSelfSigned({bool status = true}) {
    return this;
  }

  ClientBrowser setEndpoint(String endPoint) {
    this._endPoint = endPoint;
    _endPointRealtime = endPoint
        .replaceFirst('https://', 'wss://')
        .replaceFirst('http://', 'ws://');
    return this;
  }

  ClientBrowser setEndPointRealtime(String endPoint) {
    _endPointRealtime = endPoint;
    return this;
  }

  ClientBrowser addHeader(String key, String value) {
    _headers![key] = value;

    return this;
  }

  Future init() async {
    if (html.window.localStorage.keys.contains('cookieFallback')) {
      addHeader('x-fallback-cookies',
          html.window.localStorage['cookieFallback'] ?? '');
    }
    _httpClient.withCredentials = true;
  }

  Future<Response> call(
    HttpMethod method, {
    String path = '',
    Map<String, String> headers = const {},
    Map<String, dynamic> params = const {},
    ResponseType? responseType,
  }) async {
    await this.init();

    late http.Response res;
    http.BaseRequest request = this.prepareRequest(
      method,
      uri: Uri.parse(_endPoint + path),
      headers: {...this._headers!, ...headers},
      params: params,
    );
    try {
      final streamedResponse = await _httpClient.send(request);
      res = await toResponse(streamedResponse);

      final cookieFallback = res.headers['x-fallback-cookies'];
      if (cookieFallback != null) {
        print(
            'Appwrite is using localStorage for session management. Increase your security by adding a custom domain as your API endpoint.');
        addHeader('X-Fallback-Cookies', cookieFallback);
        html.window.localStorage['cookieFallback'] = cookieFallback;
      }
      return this.prepareResponse(res, responseType: responseType);
    } catch (e) {
      if (e is AppwriteException) {
        rethrow;
      }
      throw AppwriteException(e.toString());
    }
  }

  @override
  Future webAuth(Uri url) {
    throw UnimplementedError();
  }
}
