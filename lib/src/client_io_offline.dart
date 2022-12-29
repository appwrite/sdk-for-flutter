import 'dart:async';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/client_io.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:sembast/sembast.dart';
import 'package:sembast/utils/value_utils.dart';

import 'client_base.dart';
import 'client_offline_mixin.dart';
import 'enums.dart';

ClientBase createClient({
  required String endPoint,
  required bool selfSigned,
}) =>
    ClientIOOffline(
      endPoint: endPoint,
      selfSigned: selfSigned,
    );

class ClientIOOffline extends ClientIO with ClientOfflineMixin {
  bool _offlinePersistency = false;
  int _maxCacheSize = 40000; // 40MB

  ClientIOOffline({
    String endPoint = 'https://HOSTNAME/v1',
    selfSigned = false,
  }) : super(endPoint: endPoint, selfSigned: selfSigned);

  @override
  Future<Response> call(
    HttpMethod method, {
    String path = '',
    Map<String, String> headers = const {},
    Map<String, dynamic> params = const {},
    ResponseType? responseType,
  }) async {
    final uri = Uri.parse(endPoint + path);

    http.BaseRequest request = prepareRequest(
      method,
      uri: uri,
      headers: {...this.headers, ...headers},
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
                  final res = await call(
                    method,
                    headers: headers,
                    params: params,
                    path: path,
                    responseType: responseType,
                  );

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

    try {
      final response = await super.call(
        method,
        path: path,
        headers: headers,
        params: params,
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

        final model = getModel(Uri.parse(endPoint + path));
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
