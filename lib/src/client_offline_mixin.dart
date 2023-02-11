import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/src/enums.dart';
import 'package:appwrite/src/offline_db.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:sembast/sembast.dart';
import 'package:sembast/timestamp.dart';
import 'package:sembast/utils/value_utils.dart';

class AccessTimestamp {
  final String model;
  final String key;
  final Timestamp accessedAt;

  AccessTimestamp(
      {required this.model, required this.key, required this.accessedAt});

  factory AccessTimestamp.fromMap(Map<String, Object?> json) => AccessTimestamp(
        model: json["model"] as String,
        key: json["key"] as String,
        accessedAt: json["accessedAt"] as Timestamp,
      );

  Map<String, Object?> toMap() => {
        "model": model,
        "key": key,
        "accessedAt": accessedAt,
      };
}

class ClientOfflineMixin {
  ValueNotifier<bool> isOnline = ValueNotifier(true);
  late Database db;

  StoreRef<String, Map<String, Object?>> _queuedWritesStore =
      stringMapStoreFactory.store('queuedWrites');
  StoreRef<String, Map<String, Object?>> _accessTimestampsStore =
      stringMapStoreFactory.store('accessTimestamps');
  StoreRef<String, int> _cacheSizeStore = StoreRef<String, int>('cacheSize');

  Future<void> initOffline({
    required Future<Response<dynamic>> Function(HttpMethod,
            {String path,
            Map<String, String> headers,
            Map<String, dynamic> params,
            ResponseType? responseType,
            String cacheModel,
            String cacheKey,
            String cacheResponseIdKey,
            String cacheResponseContainerKey})
        call,
    void Function(Object)? onWriteQueueError,
    required int Function() getOfflineCacheSize,
  }) async {
    await Future.wait([initOfflineDatabase(), listenForConnectivity()]);
    await processWriteQueue(call, onError: onWriteQueueError);

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

  Future<void> initOfflineDatabase() async {
    db = await OfflineDatabase.instance.db();
  }

  Future<void> processWriteQueue(
      Future<Response<dynamic>> Function(HttpMethod,
              {String path,
              Map<String, String> headers,
              Map<String, dynamic> params,
              ResponseType? responseType,
              String cacheModel,
              String cacheKey,
              String cacheResponseIdKey,
              String cacheResponseContainerKey})
          call,
      {void Function(Object e)? onError}) async {
    // TODO: remove
    print('accessedAt records:');
    final records = await listAccessedAt(db);
    for (final record in records) {
      print('  ${record.value}');
    }

    if (!isOnline.value) return;
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
        final cacheModel = queuedWrite['cacheModel'] as String;
        final cacheKey = queuedWrite['cacheKey'] as String;
        final cacheResponseContainerKey =
            queuedWrite['cacheResponseContainerKey'] as String;
        final cacheResponseIdKey = queuedWrite['cacheResponseIdKey'] as String;
        final res = await call(
          method,
          path: path,
          headers: headers,
          params: params,
          cacheModel: cacheModel,
          cacheKey: cacheKey,
          cacheResponseContainerKey: cacheResponseContainerKey,
          cacheResponseIdKey: cacheResponseIdKey,
        );
        print('  res: $res');

        final modelStore = getModelStore(cacheModel);
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
        if (onError != null) {
          onError(e);
        }
        if ((e.code ?? 0) >= 400) {
          db.transaction((txn) async {
            final queuedWriteKey = queuedWriteRecord.key;
            await deleteQueuedWrite(txn, queuedWriteKey);
            // restore cach
            final previous = queuedWrite['previous'] as Map<String, Object?>?;
            final cacheModel = queuedWrite['cacheModel'] as String;
            final cacheKey = queuedWrite['cacheKey'] as String;
            final modelStore = getModelStore(cacheModel);
            if (previous != null) {
              await upsertCache(txn, modelStore, previous, key: cacheKey);
            }
          });
        }
      } catch (e) {
        if (onError != null) {
          onError(e);
        }
      }
    }
  }

  bool resultIsOnline(ConnectivityResult result) {
    return result == ConnectivityResult.mobile ||
        result == ConnectivityResult.ethernet ||
        result == ConnectivityResult.wifi;
  }

  Future<void> checkOnlineStatus() async {
    Socket? s;
    try {
      print('Checking online status...');
      s = await Socket.connect(
        'appwrite.io',
        443,
        timeout: Duration(seconds: 1),
      );
      isOnline.value = true;
    } on SocketException catch (_) {
      isOnline.value = false;
    } finally {
      s?.close();
    }
  }

  Future<void> listenForConnectivity() async {
    void handleConnectivityResult(ConnectivityResult result) {
      isOnline.value = resultIsOnline(result);
    }

    final result = await Connectivity().checkConnectivity();
    handleConnectivityResult(result);
    if (isOnline.value) {
      // wifi or mobile is connected, but double check internet connectivity
      await checkOnlineStatus();
    }
    Connectivity().onConnectivityChanged.listen(handleConnectivityResult);
  }

  Future<Response> handleOfflineRequest({
    required Uri uri,
    required HttpMethod method,
    required Future<Response<dynamic>> Function(HttpMethod,
            {String path,
            Map<String, String> headers,
            Map<String, dynamic> params,
            ResponseType? responseType,
            String cacheModel,
            String cacheKey,
            String cacheResponseIdKey,
            String cacheResponseContainerKey})
        call,
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
    if (!headers.containsKey('X-Appwrite-Timestamp')) {
      headers['X-Appwrite-Timestamp'] =
          DateTime.now().toUtc().toIso8601String();
    }
    final pathSegments = uri.pathSegments;
    String queuedWriteKey = '';

    final store = getModelStore(cacheModel);
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
          return Response(data: {
            'total': count,
            cacheResponseContainerKey: records.map((record) {
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
              document['\$createdAt'] =
                  DateTime.now().toUtc().toIso8601String();
              document['\$updatedAt'] =
                  DateTime.now().toUtc().toIso8601String();
              document['\$id'] = documentId;
              document['\$collectionId'] = pathSegments[4];
              document['\$databaseId'] = pathSegments[2];
              document['\$permissions'] = params['permissions'] ?? [];
              await db.transaction((txn) async {
                await upsertCache(txn, store, document, key: cacheKey);
                queuedWriteKey = await addQueuedWrite(
                  txn,
                  method,
                  path,
                  headers,
                  params,
                  cacheModel,
                  cacheKey,
                  cacheResponseIdKey,
                  cacheResponseContainerKey,
                  null,
                );
              });
            }
            break;
          case HttpMethod.delete:
            if (cacheKey.isNotEmpty) {
              await db.transaction((txn) async {
                final previous = await store.record(cacheKey).get(txn);
                await deleteCache(txn, store, key: cacheKey);
                queuedWriteKey = await addQueuedWrite(
                  txn,
                  method,
                  path,
                  headers,
                  params,
                  cacheModel,
                  cacheKey,
                  cacheResponseIdKey,
                  cacheResponseContainerKey,
                  previous,
                );
              });
            }
            break;
          case HttpMethod.put:
          case HttpMethod.patch:
            final entry = Map<String, dynamic>();
            if (params.containsKey('data')) {
              entry.addAll(Map<String, dynamic>.from(params['data']));
              entry['\$createdAt'] = DateTime.now().toUtc().toIso8601String();
              entry['\$updatedAt'] = DateTime.now().toUtc().toIso8601String();
              entry['\$id'] = cacheKey;
            } else if (params.containsKey('prefs')) {
              entry.addAll(Map<String, dynamic>.from(params['prefs']));
            }

            await db.transaction((txn) async {
              final previous = await store.record(cacheKey).get(txn);
              await upsertCache(txn, store, entry, key: cacheKey);
              queuedWriteKey = await addQueuedWrite(
                txn,
                method,
                path,
                headers,
                params,
                cacheModel,
                cacheKey,
                cacheResponseIdKey,
                cacheResponseContainerKey,
                previous,
              );
            });
            break;
          case HttpMethod.get:
            // already handled
            break;
        }
        final completer = Completer<Response>();
        Function() listener = () {};
        listener = () async {
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
                  futures.add(upsertCache(txn, store, res.data, key: cacheKey));
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
              if (!completer.isCompleted) {
                if (e.code == 404) {
                  // delete from cache
                  await db.transaction((txn) async {
                    await deleteCache(txn, store, key: cacheKey);
                    await deleteQueuedWrite(txn, queuedWriteKey);
                  });
                } else if ((e.code ?? 0) >= 400) {
                  // restore cache
                  final previous = queuedWrites.first.value['previous']
                      as Map<String, Object?>?;
                  await db.transaction((txn) async {
                    if (previous != null) {
                      await upsertCache(txn, store, previous, key: cacheKey);
                    }
                    await deleteQueuedWrite(txn, queuedWriteKey);
                  });
                }
                completer.completeError(e);
              }
            } catch (e) {
              if (!completer.isCompleted) {
                // restore cache
                final previous = queuedWrites.first.value['previous']
                    as Map<String, Object?>?;
                if (previous != null) {
                  await db.transaction((txn) async {
                    await upsertCache(txn, store, previous, key: cacheKey);
                    await deleteQueuedWrite(txn, queuedWriteKey);
                  });
                }
                completer.completeError(e);
              }
            }
            isOnline.removeListener(listener);
            break;
          }
        };
        isOnline.addListener(listener);
        return completer.future;
    }
  }

  void cacheResponse({
    required String cacheModel,
    required String cacheKey,
    required String cacheResponseIdKey,
    required http.BaseRequest request,
    required Response response,
  }) {
    if (cacheModel.isEmpty) return;

    final store = getModelStore(cacheModel);
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
                final id = map[cacheResponseIdKey];
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
        if (cacheModel.endsWith('/prefs')) {
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

  // String getModel(Uri uri) {
  //   final pathSegments = uri.pathSegments;
  //   if (pathSegments.length > 5 &&
  //       pathSegments[1] == 'databases' &&
  //       pathSegments[3] == 'collections' &&
  //       pathSegments[5] == 'documents') {
  //     return '/' + uri.pathSegments.sublist(0, 6).join('/');
  //   }

  //   if (pathSegments.length > 2 &&
  //       pathSegments[1] == 'account' &&
  //       pathSegments[2] == 'sessions') {
  //     return '/' + uri.pathSegments.sublist(0, 3).join('/');
  //   }

  //   return uri.path;
  // }

  // String getKey(Uri uri) {
  //   final pathSegments = uri.pathSegments;
  //   String key = '';
  //   if (pathSegments.length == 2 && pathSegments[1] == 'account') {
  //     key = 'current';
  //   } else if (pathSegments.length > 6 &&
  //       pathSegments[1] == 'databases' &&
  //       pathSegments[3] == 'collections' &&
  //       pathSegments[5] == 'documents') {
  //     key = pathSegments[6];
  //   } else if (pathSegments.length > 3 &&
  //       pathSegments[1] == 'account' &&
  //       pathSegments[2] == 'sessions') {
  //     key = pathSegments[3];
  //   } else if (pathSegments.length > 2 &&
  //       pathSegments[1] == 'account' &&
  //       pathSegments[2] == 'prefs') {
  //     key = 'current';
  //   } else if (pathSegments.length == 2 && pathSegments[1] == 'locale') {
  //     key = 'current';
  //   }

  //   return key;
  // }

  // String getId(Uri uri) {
  //   String id = '';

  //   final pathSegments = uri.pathSegments;
  //   if (pathSegments.length > 6 &&
  //       pathSegments[1] == 'databases' &&
  //       pathSegments[3] == 'collections' &&
  //       pathSegments[5] == 'documents') {
  //     id = pathSegments[6];
  //   }

  //   return id;
  // }

  String encode(Map map) {
    final encoded =
        jsonEncode(sembastCodecDefault.jsonEncodableCodec.encode(map));
    return encoded;
  }

  StoreRef<String, Map<String, Object?>> getModelStore(String model) {
    return stringMapStoreFactory.store(model);
  }

  // Future<void> addCache(
  //     DatabaseClient db,
  //     StoreRef<String, Map<String, Object?>> store,
  //     String key,
  //     Map<String, dynamic> map) async {
  //   final recordRef = store.record(key);
  //   final record = await recordRef.get(db);
  //   int change = 0;
  //   if (record == null) {
  //     final encoded = encode(map);
  //     change = encoded.length;
  //   } else {
  //     change = calculateChange(record, map);
  //   }

  //   await updateCacheSize(db, change);
  //   await recordRef.put(db, map);
  //   await updateAccessedAt(db, store.name, key);
  // }

  // Future<void> upsertCacheOld(
  //     DatabaseClient db,
  //     StoreRef<String, Map<String, Object?>> store,
  //     String id,
  //     Map<String, dynamic> map) async {
  //   final record = await store.findFirst(db,
  //       finder: Finder(filter: Filter.equals('\$id', id)));

  //   if (record == null) {
  //     final encoded = encode(map);
  //     final change = encoded.length;
  //     await updateCacheSize(db, change);
  //     final key = await store.add(db, map);
  //     await updateAccessedAt(db, store.name, key);
  //     return;
  //   }

  //   final updated = await record.ref.update(db, map);
  //   if (updated != null) {
  //     final change = calculateChange(record.value, map);
  //     await updateCacheSize(db, change);
  //   }
  //   await updateAccessedAt(db, store.name, record.key);
  // }

  Future<Map<String, Object?>> upsertCache(DatabaseClient db,
      StoreRef<String, Map<String, Object?>> store, Map<String, dynamic> map,
      {String? key, String? id}) async {
    if (key == null && id == null) {
      throw AppwriteException(
          'key and id cannot be null', 0, 'general_cache_error');
    }

    if (key != null) {
      final recordRef = store.record(key);
      final record = await recordRef.get(db);
      int change = 0;
      if (record == null) {
        final encoded = encode(map);
        change = encoded.length;
      } else {
        change = calculateChange(record, map);
      }

      await updateCacheSize(db, change);
      final result = await recordRef.put(db, map, merge: true);
      await updateAccessedAt(db, store.name, key);
      return result;
    }

    final record = await store.findFirst(db,
        finder: Finder(filter: Filter.equals('\$id', id)));

    if (record == null) {
      final encoded = encode(map);
      final change = encoded.length;
      await updateCacheSize(db, change);
      final key = await store.add(db, map);
      await updateAccessedAt(db, store.name, key);
      return record!.value;
    }

    final updated = await record.ref.put(db, map, merge: true);
    final change = calculateChange(record.value, map);
    await updateCacheSize(db, change);
    return updated;
  }

  Future<void> deleteCache(
      DatabaseClient db, StoreRef<String, Map<String, Object?>> store,
      {String? key, String? id}) async {
    if (key == null && id == null) {
      throw AppwriteException(
          'key and id cannot be null', 0, 'general_cache_error');
    }

    RecordSnapshot<String, Map<String, Object?>>? record;
    if (key != null) {
      record = await store.record(key).getSnapshot(db);
    } else {
      record = await store.findFirst(db,
          finder: Finder(filter: Filter.equals('\$id', id)));
    }

    if (record == null) {
      return;
    }
    final encoded = encode(record.value);
    final size = encoded.length;
    await updateCacheSize(db, size * -1);
    await record.ref.delete(db);
    await deleteAccessedAt(db, store.name, record.key);
  }

  Future<List<RecordSnapshot<String, Map<String, Object?>>>> listAccessedAt(
      DatabaseClient db) {
    final finder = Finder(sortOrders: [SortOrder('accessedAt')]);
    return _accessTimestampsStore.find(db, finder: finder);
  }

  Future<void> updateAccessedAt(
      DatabaseClient db, String model, String key) async {
    final value =
        AccessTimestamp(model: model, key: key, accessedAt: Timestamp.now());
    final result = await _accessTimestampsStore
        .record('$model-$key')
        .put(db, value.toMap());
    print('touched ' + result.toString());
  }

  Future<void> deleteAccessedAt(DatabaseClient db, String model, String key) {
    return _accessTimestampsStore.record('$model-$key').delete(db);
  }

  int calculateChange(Map oldMap, Map newMap) {
    final oldEncoded = encode(oldMap);
    final oldSize = oldEncoded.length;
    final newEncoded = encode(newMap);
    final newSize = newEncoded.length;
    final change = newSize - oldSize;
    return change;
  }

  RecordRef<String, int> getCacheSizeRecordRef() {
    return _cacheSizeStore.record('cacheSize');
  }

  Future<void> updateCacheSize(DatabaseClient db, int change) async {
    if (change == 0) return;

    final record = getCacheSizeRecordRef();

    final currentSize = await record.get(db) ?? 0;
    final newSize = await record.put(db, currentSize + change);

    print('updateCacheSize: $currentSize + ($change) = $newSize');
  }

  Future<List<RecordSnapshot<String, Map<String, Object?>>>> listQueuedWrites(
      DatabaseClient db) {
    return _queuedWritesStore.find(db);
  }

  Future<String> addQueuedWrite(
    DatabaseClient db,
    HttpMethod method,
    String path,
    Map<String, String> headers,
    Map<String, dynamic> params,
    String cacheModel,
    String cacheKey,
    String cacheResponseIdKey,
    String cacheResponseContainerKey,
    Map<String, Object?>? previous,
  ) async {
    return _queuedWritesStore.add(db, {
      'queuedAt': Timestamp.now(),
      'method': method.name(),
      'path': path,
      'headers': headers,
      'params': params,
      'cacheModel': cacheModel,
      'cacheKey': cacheKey,
      'cacheResponseIdKey': cacheResponseIdKey,
      'cacheResponseContainerKey': cacheResponseContainerKey,
      'previous': previous,
    });
  }

  Future<void> deleteQueuedWrite(DatabaseClient db, String key) {
    return _queuedWritesStore.record(key).delete(db);
  }
}
