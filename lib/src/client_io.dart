import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/src/client_offline_mixin.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/utils/value_utils.dart';

import 'client_base.dart';
import 'client_mixin.dart';
import 'cookie_manager.dart';
import 'enums.dart';
import 'interceptor.dart';

ClientBase createClient({
  required String endPoint,
  required bool selfSigned,
}) =>
    ClientIO(
      endPoint: endPoint,
      selfSigned: selfSigned,
    );

class ClientIO extends ClientBase with ClientMixin, ClientOfflineMixin {
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
  final List<Interceptor> _interceptors = [];

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
      'x-sdk-version': '8.2.1',
      'X-Appwrite-Response-Format' : '1.0.0',
    };

    config = {};

    assert(_endPoint.startsWith(RegExp("http://|https://")),
        "endPoint $_endPoint must start with 'http'");
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

  @override
  ClientIO addHeader(String key, String value) {
    _headers![key] = value;

    return this;
  }

  Future init() async {
    if (_initProgress) return;
    _initProgress = true;
    // if web skip cookie implementation and origin header as those are automatically handled by browsers
    final Directory cookieDir = await _getCookiePath();
    _cookieJar = PersistCookieJar(storage: FileStorage(cookieDir.path));
    _interceptors.add(CookieManager(_cookieJar));
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    addHeader('Origin',
        'appwrite-${Platform.operatingSystem}://${packageInfo.packageName}');

    //creating custom user agent
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    var device = '';
    try {
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
    } catch (e) {
      debugPrint('Error getting device info: $e');
      device = Platform.operatingSystem;
    }
    addHeader('user-agent',
        '${packageInfo.packageName}/${packageInfo.version} $device');

    _initialized = true;
    _initProgress = false;
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
    if (size <= CHUNK_SIZE) {
      if (file.path != null) {
        params[paramName] = await http.MultipartFile.fromPath(
            paramName, file.path!,
            filename: file.filename);
      } else {
        params[paramName] = http.MultipartFile.fromBytes(paramName, file.bytes!,
            filename: file.filename);
      }
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

    RandomAccessFile? raf;
    // read chunk and upload each chunk
    if (iofile != null) {
      raf = await iofile.open(mode: FileMode.read);
    }

    while (offset < size) {
      var chunk;
      if (file.bytes != null) {
        final end = min(offset + CHUNK_SIZE - 1, size - 1);
        chunk = file.bytes!.getRange(offset, end).toList();
      } else {
        raf!.setPositionSync(offset);
        chunk = raf.readSync(CHUNK_SIZE);
      }
      params[paramName] = http.MultipartFile.fromBytes(paramName, chunk,
          filename: file.filename);
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
    raf?.close();
    return res;
  }

  @override
  Future webAuth(Uri url, {String? callbackUrlScheme}) {
    return FlutterWebAuth2.authenticate(
      url: url.toString(),
      callbackUrlScheme: callbackUrlScheme != null && Platform.isWindows ? callbackUrlScheme : "appwrite-callback-" + config['project']!,
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

    final uri = Uri.parse(_endPoint + path);

    http.BaseRequest request = prepareRequest(
      method,
      uri: uri,
      headers: {..._headers!, ...headers},
      params: params,
    );

    if (getOfflinePersistency() &&
        !isOnline &&
        responseType != ResponseType.bytes) {
      final pathSegments = uri.pathSegments;
      String model = getModel(uri);
      String cacheKey = getKey(uri);
      String queuedWriteKey = '';

      final store = getModelStore(model);
      switch (method) {
        case HttpMethod.get:
          if (cacheKey.isNotEmpty) {
            final recordRef = store.record(cacheKey);
            final record = await recordRef.get(db);
            if (record != null) {
              updateAccessedAt(db, store.name, cacheKey);
              return Response(data: record);
            }
          } else {
            final finder = Finder(limit: 25);
            // TODO: await both at same time
            final records = await store.find(db, finder: finder);
            db.transaction((txn) async {
              for (final record in records) {
                await updateAccessedAt(txn, store.name, record.key);
              }
            });
            final count = await store.count(db);
            String containerKey = model.split('/').last;
            if (containerKey == 'eu') {
              containerKey = 'countries';
            }
            return Response(data: {
              'total': count,
              containerKey: records.map((record) {
                final map = Map<String, dynamic>();
                record.value.entries.forEach((entry) {
                  map[entry.key] = entry.value;
                });
                return map;
              }).toList(),
            });
          }
          throw AppwriteException(
            "Client is offline and data is not cached",
            0,
            "general_offline",
          );
        case HttpMethod.post:
        case HttpMethod.patch:
        case HttpMethod.put:
        case HttpMethod.delete:
          switch (method) {
            case HttpMethod.post:
              if (params.containsKey('data')) {
                final documentId = params['documentId'];
                cacheKey = documentId;
                final document = Map<String, dynamic>.from(params['data']);
                document['\$createdAt'] = DateTime.now().toIso8601String();
                document['\$updatedAt'] = DateTime.now().toIso8601String();
                document['\$id'] = documentId;
                document['\$collectionId'] = pathSegments[4];
                document['\$databaseId'] = pathSegments[2];
                document['\$permissions'] = params['permissions'] ?? [];
                await db.transaction((txn) async {
                  await upsertCache(txn, store, document, key: cacheKey);
                  queuedWriteKey =
                      await addQueuedWrite(txn, method, path, headers, params);
                });
              }
              break;
            case HttpMethod.delete:
              if (cacheKey.isNotEmpty) {
                await db.transaction((txn) async {
                  await deleteCache(txn, store, key: cacheKey);
                  queuedWriteKey =
                      await addQueuedWrite(txn, method, path, headers, params);
                });
              }
              break;
            case HttpMethod.put:
            case HttpMethod.patch:
              final entry = Map<String, dynamic>();
              if (params.containsKey('data')) {
                entry.addAll(Map<String, dynamic>.from(params['data']));
                entry['\$createdAt'] = DateTime.now().toIso8601String();
                entry['\$updatedAt'] = DateTime.now().toIso8601String();
                entry['\$id'] = cacheKey;
              } else if (params.containsKey('prefs')) {
                entry.addAll(Map<String, dynamic>.from(params['prefs']));
              }

              await db.transaction((txn) async {
                await upsertCache(txn, store, entry, key: cacheKey);
                queuedWriteKey =
                    await addQueuedWrite(txn, method, path, headers, params);
              });
              break;
            case HttpMethod.get:
              // already handled
              break;
          }
          final completer = Completer<Response>();
          late StreamSubscription<ConnectivityResult> subscription;
          subscription =
              Connectivity().onConnectivityChanged.listen(((result) async {
            if (resultIsOnline(result) && !request.finalized) {
              while (true) {
                final queuedWrites = await listQueuedWrites(db);

                if (queuedWrites.isEmpty) {
                  break;
                }

                if (queuedWrites.first.key != queuedWriteKey) {
                  await Future.delayed(Duration.zero);
                  continue;
                }

                try {
                  final res =
                      await sendRequest(request, responseType: responseType);

                  await db.transaction((txn) async {
                    final futures = <Future>[];
                    if (method == HttpMethod.post) {
                      futures.add(
                          upsertCache(txn, store, res.data, key: cacheKey));
                    }

                    futures.add(deleteQueuedWrite(txn, queuedWriteKey));

                    await Future.wait(futures);
                  });

                  completer.complete(res);
                } on AppwriteException catch (e) {
                  if (e.message ==
                      "Bad state: Can't finalize a finalized Request.") {
                    continue;
                  }
                  completer.completeError(e);
                } catch (e) {
                  completer.completeError(e);
                }
                subscription.cancel();
                break;
              }
            }
          }));
          return completer.future;
      }
    }

    return sendRequest(request, responseType: responseType);
  }

  Future<Response> sendRequest(
    http.BaseRequest request, {
    ResponseType? responseType,
  }) async {
    try {
      request = await _interceptRequest(request);
      final streamedResponse = await _httpClient.send(request);
      http.Response res = await toResponse(streamedResponse);
      res = await _interceptResponse(res);
      final response = prepareResponse(
        res,
        responseType: responseType,
      );

      if (getOfflinePersistency()) {
        final uri = request.url;
        String model = getModel(uri);
        String cacheKey = getKey(uri);

        final store = getModelStore(model);
        switch (request.method) {
          case 'GET':
            final clone = cloneMap(response.data);
            if (cacheKey.isNotEmpty) {
              db.transaction((txn) async {
                await upsertCache(txn, store, clone, key: cacheKey);
              });
            } else {
              clone.forEach((key, value) {
                if (key == 'total') return;
                db.transaction((txn) async {
                  for (final element in value as List) {
                    final map = element as Map<String, dynamic>;
                    final id = map['\$id'] ?? map['code'];
                    await upsertCache(txn, store, map, key: id);
                  }
                });
              });
            }
            break;
          case 'POST':
          case 'PUT':
          case 'PATCH':
            Map<String, Object?> clone = cloneMap(response.data);
            if (cacheKey.isEmpty) {
              cacheKey = clone['\$id'] as String;
            }
            if (model.endsWith('/prefs')) {
              clone = response.data['prefs'];
            }
            db.transaction((txn) async {
              await upsertCache(txn, store, clone, key: cacheKey);
            });
            break;
          case 'DELETE':
            if (cacheKey.isNotEmpty) {
              db.transaction((txn) async {
                await deleteCache(txn, store, key: cacheKey);
              });
            }
        }
      }

      return response;
    } catch (e) {
      if (e is AppwriteException) {
        rethrow;
      }
      throw AppwriteException(e.toString());
    }
  }

  @override
  Future<ClientIO> setOfflinePersistency({bool status = true}) async {
    _offlinePersistency = status;

    if (_offlinePersistency) {
      await Future.wait([initOfflineDatabase(), listenForConnectivity()]);
      await processWriteQueue();
      final cacheSizeRecordRef = getCacheSizeRecordRef();
      cacheSizeRecordRef.onSnapshot(db).listen((snapshot) {
        int? currentSize = snapshot?.value;

        if (currentSize == null || currentSize < getOfflineCacheSize()) return;

        db.transaction((txn) async {
          final records = await listAccessedAt(txn);
          if (records.isEmpty) return;
          final record = records.first;
          print('deleting $record');
          final modelStore = getModelStore(record.value['model'] as String);
          final cacheKey = record.value['key'] as String;
          await deleteCache(txn, modelStore, key: cacheKey);
        });
      });
    }

    return this;
  }

  @override
  bool getOfflinePersistency() {
    return _offlinePersistency;
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

  Future<void> processWriteQueue() async {
    // TODO: remove
    print('accessedAt records:');
    final records = await listAccessedAt(db);
    for (final record in records) {
      print('  ${record.value}');
    }

    if (getOfflinePersistency() && !isOnline) return;
    final queuedWriteRecords = await listQueuedWrites(db);
    print('queued writes:');
    for (final queuedWriteRecord in queuedWriteRecords) {
      final queuedWrite = queuedWriteRecord.value;
      print('  queuedWrite: $queuedWrite');
      try {
        final method = HttpMethod.values
            .where((v) => v.name() == queuedWrite['method'])
            .first;
        final path = queuedWrite['path'] as String;
        final headers = (queuedWrite['headers'] as Map<String, Object?>)
            .map((key, value) => MapEntry(key, value?.toString() ?? ''));
        final params = queuedWrite['params'] as Map<String, Object?>;
        final res = await this.call(
          method,
          path: path,
          headers: headers,
          params: params,
        );
        print('  res: $res');

        final model = getModel(Uri.parse(_endPoint + path));
        final modelStore = getModelStore(model);
        db.transaction((txn) async {
          final futures = <Future>[];
          if (method == HttpMethod.post) {
            final recordKey = res.data['\$id'];
            futures.add(
              upsertCache(
                txn,
                modelStore,
                res.data,
                key: recordKey,
              ),
            );
          }

          futures.add(queuedWriteRecord.ref.delete(txn));

          await Future.wait(futures);
        });
      } on AppwriteException catch (e) {
        if (e.code == 404) {
          db.transaction((txn) async {
            await queuedWriteRecord.ref.delete(txn);
          });
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
