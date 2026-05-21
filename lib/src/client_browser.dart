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
  static const int chunkSize = 5 * 1024 * 1024;
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
      'x-sdk-version': '24.2.0',
      'X-Appwrite-Response-Format': '1.9.5',
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
  /// The user cookie to authenticate with. Used by SDKs that forward an incoming Cookie header in server-side runtimes.
  @override
  ClientBrowser setCookie(value) {
    config['cookie'] = value;
    addHeader('Cookie', value);
    return this;
  }
  /// Impersonate a user by ID on an already user-authenticated request. Requires the current request to be authenticated as a user with impersonator capability; X-Appwrite-Key alone is not sufficient. Impersonator users are intentionally granted users.read so they can discover a target before impersonation begins. Internal audit logs still attribute actions to the original impersonator and record the impersonated target only in internal audit payload data.
  @override
  ClientBrowser setImpersonateUserId(value) {
    config['impersonateUserId'] = value;
    addHeader('X-Appwrite-Impersonate-User-Id', value);
    return this;
  }
  /// Impersonate a user by email on an already user-authenticated request. Requires the current request to be authenticated as a user with impersonator capability; X-Appwrite-Key alone is not sufficient. Impersonator users are intentionally granted users.read so they can discover a target before impersonation begins. Internal audit logs still attribute actions to the original impersonator and record the impersonated target only in internal audit payload data.
  @override
  ClientBrowser setImpersonateUserEmail(value) {
    config['impersonateUserEmail'] = value;
    addHeader('X-Appwrite-Impersonate-User-Email', value);
    return this;
  }
  /// Impersonate a user by phone on an already user-authenticated request. Requires the current request to be authenticated as a user with impersonator capability; X-Appwrite-Key alone is not sufficient. Impersonator users are intentionally granted users.read so they can discover a target before impersonation begins. Internal audit logs still attribute actions to the original impersonator and record the impersonated target only in internal audit payload data.
  @override
  ClientBrowser setImpersonateUserPhone(value) {
    config['impersonateUserPhone'] = value;
    addHeader('X-Appwrite-Impersonate-User-Phone', value);
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

  @override
  Map<String, String> getHeaders() {
    return Map<String, String>.from(_headers!);
  }

  Future init() async {
    final cookieFallback = web.window.localStorage.getItem('cookieFallback');
    if (cookieFallback != null) {
      addHeader('x-fallback-cookies', cookieFallback);
    }
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
    if (size <= chunkSize) {
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
    String? uploadId;
    if (idParamName.isNotEmpty) {
      //make a request to check if a file already exists
      try {
        res = await call(
          HttpMethod.get,
          path: '$path/${params[idParamName]}',
          headers: headers,
        );
        final int chunksUploaded = res.data['chunksUploaded'] as int;
        offset = chunksUploaded * chunkSize;
        uploadId = res.data['\$id'] ?? params[idParamName]?.toString();
      } on AppwriteException catch (_) {}
    }

    if (offset >= size) {
      return res;
    }

    final totalChunks = (size / chunkSize).ceil();

    Future<Response> uploadChunk(int index, int start, int end, String? id) async {
      List<int> chunk = [];
      chunk = file.bytes!.getRange(start, end).toList();

      final chunkParams = Map<String, dynamic>.from(params);
      chunkParams[paramName] = http.MultipartFile.fromBytes(
        paramName,
        chunk,
        filename: file.filename,
      );
      final chunkHeaders = Map<String, String>.from(headers);
      if (id != null && id.isNotEmpty) {
        chunkHeaders['x-appwrite-id'] = id;
      }
      chunkHeaders['content-range'] = 'bytes $start-${end - 1}/$size';

      return call(
        HttpMethod.post,
        path: path,
        headers: chunkHeaders,
        params: chunkParams,
      );
    }

    final firstStart = offset;
    final firstEnd = min(firstStart + chunkSize, size);
    final firstIndex = firstStart ~/ chunkSize;
    res = await uploadChunk(firstIndex, firstStart, firstEnd, uploadId);
    uploadId = res.data['\$id'] ?? uploadId;

    var completedChunks = firstIndex + 1;
    var uploadedBytes = firstEnd;
    var lastResponse = res;
    Response? finalResponse;

    bool isUploadComplete(Response response) {
      final chunksUploaded = response.data['chunksUploaded'];
      final chunksTotal = response.data['chunksTotal'] ?? totalChunks;
      return chunksUploaded is num && chunksTotal is num && chunksUploaded >= chunksTotal;
    }

    final progress = UploadProgress(
      $id: uploadId ?? '',
      progress: min(uploadedBytes, size) / size * 100,
      sizeUploaded: min(uploadedBytes, size),
      chunksTotal: totalChunks,
      chunksUploaded: completedChunks,
    );
    onProgress?.call(progress);

    final chunks = <Map<String, int>>[];
    for (var start = firstEnd; start < size; start += chunkSize) {
      final end = min(start + chunkSize, size);
      chunks.add({
        'index': start ~/ chunkSize,
        'start': start,
        'end': end,
      });
    }

    var nextChunk = 0;
    Future<void> uploadNext() async {
      while (nextChunk < chunks.length) {
        final chunk = chunks[nextChunk++];
        final chunkResponse = await uploadChunk(
          chunk['index']!,
          chunk['start']!,
          chunk['end']!,
          uploadId,
        );
        completedChunks++;
        uploadedBytes += chunk['end']! - chunk['start']!;
        lastResponse = chunkResponse;
        if (isUploadComplete(chunkResponse)) {
          finalResponse = chunkResponse;
        }

        final progress = UploadProgress(
          $id: uploadId ?? '',
          progress: min(uploadedBytes, size) / size * 100,
          sizeUploaded: min(uploadedBytes, size),
          chunksTotal: totalChunks,
          chunksUploaded: completedChunks,
        );
        onProgress?.call(progress);
      }
    }

    final concurrency = min(8, chunks.length);
    await Future.wait(List.generate(concurrency, (_) => uploadNext()));

    return finalResponse ?? lastResponse;
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

    // Combine headers to check for dev key
    final combinedHeaders = {..._headers!, ...headers};

    // Only include credentials when dev key is not set
    if (combinedHeaders['X-Appwrite-Dev-Key'] == null) {
      _httpClient.withCredentials = true;
    } else {
      _httpClient.withCredentials = false;
    }

    late http.Response res;
    http.BaseRequest request = prepareRequest(
      method,
      uri: Uri.parse(_endPoint + path),
      headers: combinedHeaders,
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
        web.window.localStorage.setItem('cookieFallback', cookieFallback);
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
      callbackUrlScheme: "appwrite-callback-${config['project']!}",
      options: const FlutterWebAuth2Options(useWebview: false),
    );
  }
}
