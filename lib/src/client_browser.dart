import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:http/browser_client.dart';
import 'package:http/http.dart' as http;
import 'package:universal_html/html.dart' as html;

import 'client_base.dart';
import 'client_mixin.dart';
import 'client_offline_mixin.dart';
import 'enums.dart';
import 'exception.dart';
import 'input_file.dart';
import 'response.dart';
import 'upload_progress.dart';

ClientBase createClient({
  required String endPoint,
  required bool selfSigned,
}) =>
    ClientBrowser(endPoint: endPoint, selfSigned: selfSigned);

class ClientBrowser extends ClientBase with ClientMixin, ClientOfflineMixin {
  static const int CHUNK_SIZE = 5 * 1024 * 1024;
  String _endPoint;
  Map<String, String>? _headers;
  @override
  late Map<String, String> config;
  late BrowserClient _httpClient;
  String? _endPointRealtime;
  bool _offlinePersistency = false;
  int _maxCacheSize = 40000; // 40MB

  @override
  String? get endPointRealtime => _endPointRealtime;

  ClientBrowser({
    String endPoint = 'https://HOSTNAME/v1',
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
      'x-sdk-version': '8.2.1',
      'X-Appwrite-Response-Format': '1.0.0',
    };

    config = {};

    assert(_endPoint.startsWith(RegExp("http://|https://")),
        "endPoint $_endPoint must start with 'http'");
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

  @override
  ClientBrowser setSelfSigned({bool status = true}) {
    return this;
  }

  @override
  ClientBrowser setEndpoint(String endPoint) {
    _endPoint = endPoint;
    _endPointRealtime = endPoint
        .replaceFirst('https://', 'wss://')
        .replaceFirst('http://', 'ws://');
    return this;
  }

  @override
  ClientBrowser setEndPointRealtime(String endPoint) {
    _endPointRealtime = endPoint;
    return this;
  }

  bool getOfflinePersistency() {
    return _offlinePersistency;
  }

  @override
  Future<ClientBrowser> setOfflinePersistency(
      {bool status = true, void Function(Object)? onWriteQueueError}) async {
    isOnline.addListener(() {
      print('isOnline: ${isOnline.value}');
    });
    _offlinePersistency = status;

    if (_offlinePersistency) {
      await initOffline(
        call: call,
        onWriteQueueError: onWriteQueueError,
        getOfflineCacheSize: getOfflineCacheSize,
      );
    }

    return this;
  }

  @override
  ClientBrowser setOfflineCacheSize(int kbytes) {
    _maxCacheSize = kbytes * 1000;

    return this;
  }

  @override
  int getOfflineCacheSize() {
    return _maxCacheSize;
  }

  @override
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
    if (idParamName.isNotEmpty && params[idParamName] != 'unique()') {
      //make a request to check if a file already exists
      try {
        res = await call(
          HttpMethod.get,
          path: path + '/' + params[idParamName],
          headers: headers,
        );
        final int chunksUploaded = res.data['chunksUploaded'] as int;
        offset = min(size, chunksUploaded * CHUNK_SIZE);
      } on AppwriteException catch (_) {}
    }

    while (offset < size) {
      var chunk;
      final end = min(offset + CHUNK_SIZE, size);
      chunk = file.bytes!.getRange(offset, end).toList();
      params[paramName] = http.MultipartFile.fromBytes(
        paramName,
        chunk,
        filename: file.filename,
      );
      headers['content-range'] =
          'bytes $offset-${min<int>(((offset + CHUNK_SIZE) - 1), size)}/$size';
      res = await call(HttpMethod.post,
          path: path, headers: headers, params: params);
      offset += CHUNK_SIZE;
      if (offset < size) {
        headers['x-appwrite-id'] = res.data['\$id'];
      }
      final progress = UploadProgress(
        $id: res.data['\$id'] ?? '',
        progress: min(offset - 1, size) / size * 100,
        sizeUploaded: min(offset - 1, size),
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
    String cacheModel = '',
    String cacheKey = '',
    String cacheResponseIdKey = '',
    String cacheResponseContainerKey = '',
    Map<String, Object?>? previous,
  }) async {
    while (true) {
      final uri = Uri.parse(endPoint + path);

      http.BaseRequest request = prepareRequest(
        method,
        uri: uri,
        headers: {..._headers!, ...headers},
        params: params,
      );

      if (getOfflinePersistency() && !isOnline.value) {
        await checkOnlineStatus();
      }

      if (cacheModel.isNotEmpty &&
          getOfflinePersistency() &&
          !isOnline.value &&
          responseType != ResponseType.bytes) {
        return handleOfflineRequest(
          uri: uri,
          method: method,
          call: call,
          path: path,
          headers: headers,
          params: params,
          responseType: responseType,
          cacheModel: cacheModel,
          cacheKey: cacheKey,
          cacheResponseIdKey: cacheResponseIdKey,
          cacheResponseContainerKey: cacheResponseContainerKey,
        );
      }

      try {
        final response = await send(
          method,
          path: path,
          headers: headers,
          params: params,
          responseType: responseType,
          cacheModel: cacheModel,
          cacheKey: cacheKey,
          cacheResponseIdKey: cacheResponseIdKey,
          cacheResponseContainerKey: cacheResponseContainerKey,
        );

        if (getOfflinePersistency()) {
          cacheResponse(
            cacheModel: cacheModel,
            cacheKey: cacheKey,
            cacheResponseIdKey: cacheResponseIdKey,
            request: request,
            response: response,
          );
        }

        return response;
      } on AppwriteException catch (e) {
        if ((e.message != "Network is unreachable" &&
                !(e.message?.contains("Failed host lookup") ?? false)) ||
            !getOfflinePersistency()) {
          rethrow;
        }
        isOnline.value = false;
      } on SocketException catch (_) {
        if (!getOfflinePersistency()) {
          rethrow;
        }
        isOnline.value = false;
      } catch (e) {
        throw AppwriteException(e.toString());
      }
    }
  }

  Future<Response> send(
    HttpMethod method, {
    String path = '',
    Map<String, String> headers = const {},
    Map<String, dynamic> params = const {},
    ResponseType? responseType,
    String cacheModel = '',
    String cacheKey = '',
    String cacheResponseIdKey = '',
    String cacheResponseContainerKey = '',
    Map<String, Object?>? previous,
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
            'Appwrite is using localStorage for session management. Increase your security by adding a custom domain as your API endpoint.');
        addHeader('X-Fallback-Cookies', cookieFallback);
        html.window.localStorage['cookieFallback'] = cookieFallback;
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
    );
  }
}
