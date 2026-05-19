import 'dart:io';
import 'dart:math';
import 'dart:convert';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'client_mixin.dart';
import 'client_base.dart';
import 'cookie_manager.dart';
import 'enums.dart';
import 'exception.dart';
import 'interceptor.dart';
import 'response.dart';
import 'package:flutter/foundation.dart';
import 'input_file.dart';
import 'upload_progress.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

ClientBase createClient({required String endPoint, required bool selfSigned}) =>
    ClientIO(endPoint: endPoint, selfSigned: selfSigned);

class ClientIO extends ClientBase with ClientMixin {
  static const int chunkSize = 5 * 1024 * 1024;
  String _endPoint;
  Map<String, String>? _headers;
  @override
  late Map<String, String> config;
  bool selfSigned;
  bool _initProgress = false;
  bool _initialized = false;
  String? _endPointRealtime;
  late http.Client _httpClient;
  late HttpClient _nativeClient;
  late CookieJar _cookieJar;
  final List<Interceptor> _interceptors = [];

  bool get initProgress => _initProgress;
  bool get initialized => _initialized;
  CookieJar get cookieJar => _cookieJar;
  @override
  String? get endPointRealtime => _endPointRealtime;

  ClientIO({
    String endPoint = 'https://cloud.appwrite.io/v1',
    this.selfSigned = false,
  }) : _endPoint = endPoint {
    _nativeClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => selfSigned);
    _httpClient = IOClient(_nativeClient);
    _endPointRealtime = endPoint
        .replaceFirst('https://', 'wss://')
        .replaceFirst('http://', 'ws://');
    _headers = {
      'content-type': 'application/json',
      'x-sdk-name': 'Flutter',
      'x-sdk-platform': 'client',
      'x-sdk-language': 'flutter',
      'x-sdk-version': '25.0.0',
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

  Future<Directory> _getCookiePath() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final Directory dir = Directory('$path/cookies');
    await dir.create();
    return dir;
  }

  /// Your project ID
  @Deprecated('Use Client.from or another factory constructor instead.')
  @override
  ClientIO setProject(value) {
    config['project'] = value;
    addHeader('X-Appwrite-Project', value);
    return this;
  }

  /// Your secret JSON Web Token
  @Deprecated('Use Client.from or another factory constructor instead.')
  @override
  ClientIO setJWT(value) {
    config['jWT'] = value;
    addHeader('X-Appwrite-JWT', value);
    return this;
  }

  @Deprecated('Use Client.from or another factory constructor instead.')
  @override
  ClientIO setLocale(value) {
    config['locale'] = value;
    addHeader('X-Appwrite-Locale', value);
    return this;
  }

  /// The user session to authenticate with
  @Deprecated('Use Client.from or another factory constructor instead.')
  @override
  ClientIO setSession(value) {
    config['session'] = value;
    addHeader('X-Appwrite-Session', value);
    return this;
  }

  /// Your secret dev API key
  @Deprecated('Use Client.from or another factory constructor instead.')
  @override
  ClientIO setDevKey(value) {
    config['devKey'] = value;
    addHeader('X-Appwrite-Dev-Key', value);
    return this;
  }

  /// The user cookie to authenticate with. Used by SDKs that forward an incoming Cookie header in server-side runtimes.
  @Deprecated('Use Client.from or another factory constructor instead.')
  @override
  ClientIO setCookie(value) {
    config['cookie'] = value;
    addHeader('Cookie', value);
    return this;
  }

  /// Impersonate a user by ID on an already user-authenticated request. Requires the current request to be authenticated as a user with impersonator capability; X-Appwrite-Key alone is not sufficient. Impersonator users are intentionally granted users.read so they can discover a target before impersonation begins. Internal audit logs still attribute actions to the original impersonator and record the impersonated target only in internal audit payload data.
  @Deprecated('Use Client.from or another factory constructor instead.')
  @override
  ClientIO setImpersonateUserId(value) {
    config['impersonateUserId'] = value;
    addHeader('X-Appwrite-Impersonate-User-Id', value);
    return this;
  }

  /// Impersonate a user by email on an already user-authenticated request. Requires the current request to be authenticated as a user with impersonator capability; X-Appwrite-Key alone is not sufficient. Impersonator users are intentionally granted users.read so they can discover a target before impersonation begins. Internal audit logs still attribute actions to the original impersonator and record the impersonated target only in internal audit payload data.
  @Deprecated('Use Client.from or another factory constructor instead.')
  @override
  ClientIO setImpersonateUserEmail(value) {
    config['impersonateUserEmail'] = value;
    addHeader('X-Appwrite-Impersonate-User-Email', value);
    return this;
  }

  /// Impersonate a user by phone on an already user-authenticated request. Requires the current request to be authenticated as a user with impersonator capability; X-Appwrite-Key alone is not sufficient. Impersonator users are intentionally granted users.read so they can discover a target before impersonation begins. Internal audit logs still attribute actions to the original impersonator and record the impersonated target only in internal audit payload data.
  @Deprecated('Use Client.from or another factory constructor instead.')
  @override
  ClientIO setImpersonateUserPhone(value) {
    config['impersonateUserPhone'] = value;
    addHeader('X-Appwrite-Impersonate-User-Phone', value);
    return this;
  }

  @Deprecated('Use Client.from or another factory constructor instead.')
  @override
  ClientIO setSelfSigned({bool status = true}) {
    selfSigned = status;
    _nativeClient.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => status);
    return this;
  }

  @Deprecated('Use Client.from or another factory constructor instead.')
  @override
  ClientIO setEndpoint(String endPoint) {
    if (!endPoint.startsWith('http://') && !endPoint.startsWith('https://')) {
      throw AppwriteException('Invalid endpoint URL: $endPoint');
    }

    _endPoint = endPoint;
    _endPointRealtime = endPoint
        .replaceFirst('https://', 'wss://')
        .replaceFirst('http://', 'ws://');

    return this;
  }

  @Deprecated('Use Client.from or another factory constructor instead.')
  @override
  ClientIO setEndPointRealtime(String endPoint) {
    if (!endPoint.startsWith('ws://') && !endPoint.startsWith('wss://')) {
      throw AppwriteException('Invalid realtime endpoint URL: $endPoint');
    }

    _endPointRealtime = endPoint;
    return this;
  }

  @override
  ClientIO addHeader(String key, String value) {
    _headers![key] = value;

    return this;
  }

  @override
  Map<String, String> getHeaders() {
    return Map<String, String>.from(_headers!);
  }

  Future init() async {
    if (_initProgress) return;
    _initProgress = true;
    final Directory cookieDir = await _getCookiePath();
    _cookieJar = PersistCookieJar(storage: FileStorage(cookieDir.path));
    _interceptors.add(CookieManager(_cookieJar));

    var device = '';
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      addHeader(
        'Origin',
        'appwrite-${Platform.operatingSystem}://${packageInfo.packageName}',
      );

      //creating custom user agent
      DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        final andinfo = await deviceInfoPlugin.androidInfo;
        device =
            '(Linux; U; Android ${andinfo.version.release}; ${andinfo.brand} ${andinfo.model})';
      }
      if (Platform.isIOS) {
        final iosinfo = await deviceInfoPlugin.iosInfo;
        device = '${iosinfo.utsname.machine} iOS/${iosinfo.systemVersion}';
      }
      if (Platform.isLinux) {
        final lininfo = await deviceInfoPlugin.linuxInfo;
        device = '(Linux; U; ${lininfo.id} ${lininfo.version})';
      }
      if (Platform.isWindows) {
        final wininfo = await deviceInfoPlugin.windowsInfo;
        device =
            '(Windows NT; ${wininfo.computerName})'; //can't seem to get much info here
      }
      if (Platform.isMacOS) {
        final macinfo = await deviceInfoPlugin.macOsInfo;
        device = '(Macintosh; ${macinfo.model})';
      }
      addHeader(
        'user-agent',
        '${packageInfo.packageName}/${packageInfo.version} $device',
      );
    } catch (e) {
      device = Platform.operatingSystem;
      addHeader('user-agent', device);
    }

    _initialized = true;
    _initProgress = false;
  }

  @override
  Future<WebSocketChannel> realtimeWebSocket(Uri uri) async {
    Map<String, String>? headers;
    while (!_initialized && _initProgress) {
      await Future.delayed(Duration(milliseconds: 10));
    }
    if (!_initialized) {
      await init();
    }
    final cookies = await _cookieJar.loadForRequest(uri);
    headers = {HttpHeaders.cookieHeader: CookieManager.getCookies(cookies)};

    return IOWebSocketChannel(selfSigned
        ? await _connectRealtimeForSelfSignedCert(uri, headers)
        : await WebSocket.connect(uri.toString(), headers: headers));
  }

  @override
  String? realtimeFallbackCookie() => null;

  // https://github.com/jonataslaw/getsocket/blob/f25b3a264d8cc6f82458c949b86d286cd0343792/lib/src/io.dart#L104
  // and from official dart sdk websocket_impl.dart connect method
  Future<WebSocket> _connectRealtimeForSelfSignedCert(
      Uri uri, Map<String, dynamic> headers) async {
    try {
      var r = Random();
      var key = base64.encode(List<int>.generate(16, (_) => r.nextInt(255)));
      var client = HttpClient(context: SecurityContext());
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };

      uri = Uri(
        scheme: uri.scheme == 'wss' ? 'https' : 'http',
        userInfo: uri.userInfo,
        host: uri.host,
        port: uri.port,
        path: uri.path,
        query: uri.query,
        fragment: uri.fragment,
      );

      var request = await client.getUrl(uri);

      headers.forEach((key, value) => request.headers.add(key, value));

      request.headers
        ..set(HttpHeaders.connectionHeader, "Upgrade")
        ..set(HttpHeaders.upgradeHeader, "websocket")
        ..set("Sec-WebSocket-Key", key)
        ..set("Cache-Control", "no-cache")
        ..set("Sec-WebSocket-Version", "13");

      var response = await request.close();

      // ignore: close_sinks
      var socket = await response.detachSocket();
      var webSocket = WebSocket.fromUpgradedSocket(socket, serverSide: false);
      return webSocket;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.BaseRequest> _interceptRequest(http.BaseRequest request) async {
    final body = (request is http.Request) ? request.body : '';
    for (final i in _interceptors) {
      request = await i.onRequest(request);
    }

    if (request is http.Request) {
      assert(
        body == request.body,
        'Interceptors should not transform the body of the request'
        'Use Request converter instead',
      );
    }
    return request;
  }

  Future<http.Response> _interceptResponse(http.Response response) async {
    final body = response.body;
    for (final i in _interceptors) {
      response = await i.onResponse(response);
    }

    assert(
      body == response.body,
      'Interceptors should not transform the body of the response',
    );
    return response;
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
    if (file.path == null && file.bytes == null) {
      throw AppwriteException("File path or bytes must be provided");
    }

    int size = 0;
    if (file.bytes != null) {
      size = file.bytes!.length;
    }

    File? iofile;

    if (file.path != null) {
      iofile = File(file.path!);
      size = await iofile.length();
    }

    late Response res;
    if (size <= chunkSize) {
      if (file.path != null) {
        params[paramName] = await http.MultipartFile.fromPath(
          paramName,
          file.path!,
          filename: file.filename,
        );
      } else {
        params[paramName] = http.MultipartFile.fromBytes(
          paramName,
          file.bytes!,
          filename: file.filename,
        );
      }
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
          path: '$path/${params[idParamName]}',
          headers: headers,
        );
        final int chunksUploaded = res.data['chunksUploaded'] as int;
        offset = chunksUploaded * chunkSize;
      } on AppwriteException catch (_) {}
    }

    RandomAccessFile? raf;
    // read chunk and upload each chunk
    if (iofile != null) {
      raf = await iofile.open(mode: FileMode.read);
    }

    while (offset < size) {
      List<int> chunk = [];
      if (file.bytes != null) {
        final end = min(offset + chunkSize, size);
        chunk = file.bytes!.getRange(offset, end).toList();
      } else {
        raf!.setPositionSync(offset);
        chunk = raf.readSync(chunkSize);
      }
      params[paramName] = http.MultipartFile.fromBytes(
        paramName,
        chunk,
        filename: file.filename,
      );
      headers['content-range'] =
          'bytes $offset-${min<int>((offset + chunkSize - 1), size - 1)}/$size';
      res = await call(
        HttpMethod.post,
        path: path,
        headers: headers,
        params: params,
      );
      offset += chunkSize;
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
    raf?.close();
    return res;
  }

  bool get _customSchemeAllowed => Platform.isWindows || Platform.isLinux;

  @override
  Future webAuth(Uri url, {String? callbackUrlScheme}) {
    return FlutterWebAuth2.authenticate(
      url: url.toString(),
      callbackUrlScheme: callbackUrlScheme != null && _customSchemeAllowed
          ? callbackUrlScheme
          : "appwrite-callback-${config['project']!}",
      options: const FlutterWebAuth2Options(
        useWebview: false,
      ),
    ).then((value) async {
      Uri url = Uri.parse(value);
      final key = url.queryParameters['key'];
      final secret = url.queryParameters['secret'];
      if (key == null || secret == null) {
        throw AppwriteException(
          "Invalid OAuth2 Response. Key and Secret not available.",
          500,
        );
      }
      Cookie cookie = Cookie(key, secret);
      cookie.domain = Uri.parse(_endPoint).host;
      cookie.httpOnly = true;
      cookie.path = '/';
      List<Cookie> cookies = [cookie];
      await init();
      _cookieJar.saveFromResponse(Uri.parse(_endPoint), cookies);
    });
  }

  @override
  Future<Response> call(
    HttpMethod method, {
    String path = '',
    Map<String, String> headers = const {},
    Map<String, dynamic> params = const {},
    ResponseType? responseType,
  }) async {
    while (!_initialized && _initProgress) {
      await Future.delayed(Duration(milliseconds: 10));
    }
    if (!_initialized) {
      await init();
    }

    late http.Response res;
    http.BaseRequest request = prepareRequest(
      method,
      uri: Uri.parse(_endPoint + path),
      headers: {..._headers!, ...headers},
      params: params,
    );

    try {
      request = await _interceptRequest(request);
      final streamedResponse = await _httpClient.send(request);
      res = await toResponse(streamedResponse);
      res = await _interceptResponse(res);

      return prepareResponse(res, responseType: responseType);
    } catch (e) {
      if (e is AppwriteException) {
        rethrow;
      }
      throw AppwriteException(e.toString());
    }
  }
}
