import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:http/http.dart' as http;
import 'package:http/browser_client.dart';
import 'package:web/web.dart' as web;
import 'client_mixin.dart';
import 'enums.dart';
import 'exception.dart';
import 'client_base.dart';
import 'input_file.dart';
import 'upload_progress.dart';
import 'response.dart';

ClientBase createClient({required String endPoint, required bool selfSigned}) =>
    ClientBrowser(endPoint: endPoint, selfSigned: selfSigned);

class ClientBrowser extends ClientBase with ClientMixin {
  static const int CHUNK_SIZE = 5 * 1024 * 1024;
  String _endPoint;
  Map<String, String>? _headers;
  @override
  late Map<String, String> config;
  late BrowserClient _httpClient;
  String? _endPointRealtime;

  @override
  String? get endPointRealtime => _endPointRealtime;

  ClientBrowser({
    String endPoint = 'https://cloud.appwrite.io/v1',
    bool selfSigned = false,
  }) : _endPoint = endPoint {
    _httpClient = BrowserClient();
    _endPointRealtime = endPoint
        .replaceFirst('https://', 'wss://')
        .replaceFirst('http://', 'ws://');
    _headers = {
      'content-type': 'application/json',
      'x-sdk-name': 'Flutter',
      'x-sdk-platform': 'client',
      'x-sdk-language': 'flutter',
      'x-sdk-version': '17.0.0',
      'X-Appwrite-Response-Format': '1.7.0',
    };

    config = {};

    assert(
      _endPoint.startsWith(RegExp("http://|https://")),
      "endPoint $_endPoint must start with 'http'",
    );
    init();
  }

  @override
  String get endPoint => _endPoint;

  /// Your project ID
  @override
  ClientBrowser setProject(value) {
    config['project'] = value;
    addHeader('X-Appwrite-Project', value);
    return this;
  }

  /// Your secret JSON Web Token
  @override
  ClientBrowser setJWT(value) {
    config['jWT'] = value;
    addHeader('X-Appwrite-JWT', value);
    return this;
  }

  @override
  ClientBrowser setLocale(value) {
    config['locale'] = value;
    addHeader('X-Appwrite-Locale', value);
    return this;
  }

  /// The user session to authenticate with
  @override
  ClientBrowser setSession(value) {
    config['session'] = value;
    addHeader('X-Appwrite-Session', value);
    return this;
  }

  /// Your secret dev API key
  @override
  ClientBrowser setDevKey(value) {
    config['devKey'] = value;
    addHeader('X-Appwrite-Dev-Key', value);
    return this;
  }

  @override
  ClientBrowser setSelfSigned({bool status = true}) {
    return this;
  }

  @override
  ClientBrowser setEndpoint(String endPoint) {
    if (!endPoint.startsWith('http://') && !endPoint.startsWith('https://')) {
      throw AppwriteException('Invalid endpoint URL: $endPoint');
    }

    _endPoint = endPoint;
    _endPointRealtime = endPoint
        .replaceFirst('https://', 'wss://')
        .replaceFirst('http://', 'ws://');

    return this;
  }

  @override
  ClientBrowser setEndPointRealtime(String endPoint) {
    if (!endPoint.startsWith('ws://') && !endPoint.startsWith('wss://')) {
      throw AppwriteException('Invalid realtime endpoint URL: $endPoint');
    }

    _endPointRealtime = endPoint;
    return this;
  }

  @override
  ClientBrowser addHeader(String key, String value) {
    _headers![key] = value;

    return this;
  }

  Future init() async {
    final cookieFallback = web.window.localStorage['cookieFallback'];
    if (cookieFallback != null) {
      addHeader('x-fallback-cookies', cookieFallback);
    }
    _httpClient.withCredentials = true;
  }

  @override
  Future<Response> chunkedUpload({
    required String path,
    required Map<String, dynamic> params,
    required String paramName,
    required String idParamName,
    required Map<String, String> headers,
    Function(UploadProgress)? onProgress,
  }) async {
    InputFile file = params[paramName];
    if (file.bytes == null) {
      throw AppwriteException("File bytes must be provided for Flutter web");
    }

    int size = file.bytes!.length;

    late Response res;
    if (size <= CHUNK_SIZE) {
      params[paramName] = http.MultipartFile.fromBytes(
        paramName,
        file.bytes!,
        filename: file.filename,
      );
      return call(
        HttpMethod.post,
        path: path,
        params: params,
        headers: headers,
      );
    }

    var offset = 0;
    if (idParamName.isNotEmpty) {
      //make a request to check if a file already exists
      try {
        res = await call(
          HttpMethod.get,
          path: path + '/' + params[idParamName],
          headers: headers,
        );
        final int chunksUploaded = res.data['chunksUploaded'] as int;
        offset = chunksUploaded * CHUNK_SIZE;
      } on AppwriteException catch (_) {}
    }

    while (offset < size) {
      List<int> chunk = [];
      final end = min(offset + CHUNK_SIZE, size);
      chunk = file.bytes!.getRange(offset, end).toList();
      params[paramName] = http.MultipartFile.fromBytes(
        paramName,
        chunk,
        filename: file.filename,
      );
      headers['content-range'] =
          'bytes $offset-${min<int>((offset + CHUNK_SIZE - 1), size - 1)}/$size';
      res = await call(
        HttpMethod.post,
        path: path,
        headers: headers,
        params: params,
      );
      offset += CHUNK_SIZE;
      if (offset < size) {
        headers['x-appwrite-id'] = res.data['\$id'];
      }
      final progress = UploadProgress(
        $id: res.data['\$id'] ?? '',
        progress: min(offset, size) / size * 100,
        sizeUploaded: min(offset, size),
        chunksTotal: res.data['chunksTotal'] ?? 0,
        chunksUploaded: res.data['chunksUploaded'] ?? 0,
      );
      onProgress?.call(progress);
    }
    return res;
  }

  @override
  Future<Response> call(
    HttpMethod method, {
    String path = '',
    Map<String, String> headers = const {},
    Map<String, dynamic> params = const {},
    ResponseType? responseType,
  }) async {
    await init();

    late http.Response res;
    http.BaseRequest request = prepareRequest(
      method,
      uri: Uri.parse(_endPoint + path),
      headers: {..._headers!, ...headers},
      params: params,
    );
    try {
      final streamedResponse = await _httpClient.send(request);
      res = await toResponse(streamedResponse);

      final cookieFallback = res.headers['x-fallback-cookies'];
      if (cookieFallback != null) {
        debugPrint(
          'Appwrite is using localStorage for session management. Increase your security by adding a custom domain as your API endpoint.',
        );
        addHeader('X-Fallback-Cookies', cookieFallback);
        web.window.localStorage['cookieFallback'] = cookieFallback;
      }
      return prepareResponse(res, responseType: responseType);
    } catch (e) {
      if (e is AppwriteException) {
        rethrow;
      }
      throw AppwriteException(e.toString());
    }
  }

  @override
  Future webAuth(Uri url, {String? callbackUrlScheme}) {
    return FlutterWebAuth2.authenticate(
      url: url.toString(),
      callbackUrlScheme: "appwrite-callback-" + config['project']!,
      options: const FlutterWebAuth2Options(useWebview: false),
    );
  }
}
