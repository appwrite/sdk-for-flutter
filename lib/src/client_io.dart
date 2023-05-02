import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

import 'call_handlers/call_handler.dart';
import 'call_handlers/cookie_auth_call_handler.dart';
import 'call_handlers/http_call_handler.dart';
import 'call_handlers/offline_call_handler.dart';
import 'call_params.dart';
import 'client_base.dart';
import 'client_mixin.dart';
import 'enums.dart';
import 'exception.dart';
import 'input_file.dart';
import 'response.dart';
import 'upload_progress.dart';

ClientBase createClient({
  required String endPoint,
  required bool selfSigned,
}) =>
    ClientIO(
      endPoint: endPoint,
      selfSigned: selfSigned,
    );

class ClientIO extends ClientBase with ClientMixin {
  static const int CHUNK_SIZE = 5 * 1024 * 1024;
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
  late CallHandler _handler;
  late OfflineCallHandler _offlineHandler;

  bool get initProgress => _initProgress;
  bool get initialized => _initialized;
  CookieJar get cookieJar => _cookieJar;
  @override
  String? get endPointRealtime => _endPointRealtime;
  bool _offlinePersistency = false;
  int _maxCacheSize = 40000; // 40MB

  ClientIO({
    String endPoint = 'https://HOSTNAME/v1',
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
      'x-sdk-version': '9.0.0',
      'X-Appwrite-Response-Format': '1.0.0',
    };

    config = {};

    assert(_endPoint.startsWith(RegExp("http://|https://")),
        "endPoint $_endPoint must start with 'http'");

    _handler = HttpCallHandler(_httpClient);
    _offlineHandler = OfflineCallHandler(call);

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
  @override
  ClientIO setProject(value) {
    config['project'] = value;
    addHeader('X-Appwrite-Project', value);
    return this;
  }

  /// Your secret JSON Web Token
  @override
  ClientIO setJWT(value) {
    config['jWT'] = value;
    addHeader('X-Appwrite-JWT', value);
    return this;
  }

  @override
  ClientIO setLocale(value) {
    config['locale'] = value;
    addHeader('X-Appwrite-Locale', value);
    return this;
  }

  @override
  ClientIO setSelfSigned({bool status = true}) {
    selfSigned = status;
    _nativeClient.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => status);
    return this;
  }

  @override
  ClientIO setEndpoint(String endPoint) {
    _endPoint = endPoint;
    _endPointRealtime = endPoint
        .replaceFirst('https://', 'wss://')
        .replaceFirst('http://', 'ws://');
    return this;
  }

  @override
  ClientIO setEndPointRealtime(String endPoint) {
    _endPointRealtime = endPoint;
    return this;
  }

  bool getOfflinePersistency() {
    return _offlinePersistency;
  }

  @override
  Future<ClientIO> setOfflinePersistency(
      {bool status = true, void Function(Object)? onWriteQueueError}) async {
    _offlinePersistency = status;

    if (_offlinePersistency) {
      await _offlineHandler.initOffline(
        call: call,
        onWriteQueueError: onWriteQueueError,
        getOfflineCacheSize: getOfflineCacheSize,
      );
    }

    return this;
  }

  @override
  ClientIO setOfflineCacheSize(int kbytes) {
    _maxCacheSize = kbytes * 1000;

    return this;
  }

  @override
  int getOfflineCacheSize() {
    return _maxCacheSize;
  }

  @override
  ClientIO addHeader(String key, String value) {
    _headers![key] = value;

    return this;
  }

  Future init() async {
    if (_initProgress) return;
    _initProgress = true;
    final Directory cookieDir = await _getCookiePath();
    _cookieJar = PersistCookieJar(storage: FileStorage(cookieDir.path));
    addHandler(CookieAuthCallHandler(_cookieJar));
    addHandler(_offlineHandler);

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
      debugPrint('Error getting device info: $e');
      device = Platform.operatingSystem;
      addHeader('user-agent', '$device');
    }

    _initialized = true;
    _initProgress = false;
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
    if (size <= CHUNK_SIZE) {
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
      return call(CallParams(
        HttpMethod.post,
        path,
        params: params,
        headers: headers,
      ));
    }

    var offset = 0;
    if (idParamName.isNotEmpty && params[idParamName] != 'unique()') {
      //make a request to check if a file already exists
      try {
        res = await call(CallParams(
          HttpMethod.get,
          path + '/' + params[idParamName],
          headers: headers,
        ));
        final int chunksUploaded = res.data['chunksUploaded'] as int;
        offset = min(size, chunksUploaded * CHUNK_SIZE);
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
        final end = min(offset + CHUNK_SIZE - 1, size - 1);
        chunk = file.bytes!.getRange(offset, end).toList();
      } else {
        raf!.setPositionSync(offset);
        chunk = raf.readSync(CHUNK_SIZE);
      }
      params[paramName] = http.MultipartFile.fromBytes(
        paramName,
        chunk,
        filename: file.filename,
      );
      headers['content-range'] =
          'bytes $offset-${min<int>(((offset + CHUNK_SIZE) - 1), size)}/$size';
      res = await call(CallParams(
        HttpMethod.post,
        path,
        headers: headers,
        params: params,
      ));
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
    raf?.close();
    return res;
  }

  @override
  Future webAuth(Uri url, {String? callbackUrlScheme}) {
    return FlutterWebAuth2.authenticate(
      url: url.toString(),
      callbackUrlScheme: callbackUrlScheme != null && Platform.isWindows
          ? callbackUrlScheme
          : "appwrite-callback-" + config['project']!,
      preferEphemeral: true,
    ).then((value) async {
      Uri url = Uri.parse(value);
      final key = url.queryParameters['key'];
      final secret = url.queryParameters['secret'];
      if (key == null || secret == null) {
        throw AppwriteException(
            "Invalid OAuth2 Response. Key and Secret not available.", 500);
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
  Future<Response> call(CallParams params) async {
    params.headers.addAll(this._headers!);
    final response = await _handler.handleCall(
      withOfflinePersistency(
        withEndpoint(params, endPoint),
        getOfflinePersistency(),
      ),
    );

    return response;
  }

  @override
  ClientBase addHandler(CallHandler handler) {
    handler.setNext(_handler);
    _handler = handler;
    return this;
  }
}
