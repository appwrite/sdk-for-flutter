import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:sembast/utils/value_utils.dart';

import 'call_handlers/offline_call_handler.dart';
import 'call_params.dart';
import 'enums.dart';
import 'exception.dart';
import 'offline/caller.dart';
import 'offline/services/accessed_at.dart';
import 'offline/services/cache_size.dart';
import 'offline/services/model_data.dart';
import 'offline/services/queued_writes.dart';
import 'offline_db_stub.dart'
    if (dart.library.html) 'offline_db_web.dart'
    if (dart.library.io) 'offline_db_io.dart';
import 'response.dart';

class ClientOfflineMixin {
  ValueNotifier<bool> isOnline = ValueNotifier(true);
  late OfflineDatabase offlineDb;
  late ModelData _modelData;
  late AccessedAt _accessedAt;
  late CacheSize _cacheSize;
  late QueuedWrites _queuedWrites;

  Future<void> initOffline({
    required Caller call,
    void Function(Object)? onWriteQueueError,
    required int Function() getOfflineCacheSize,
  }) async {
    await Future.wait([initOfflineDatabase(), listenForConnectivity()]);
    await processWriteQueue(call, onError: onWriteQueueError);

    _cacheSize.onChange((currentSize) async {
      if (currentSize == null || currentSize < getOfflineCacheSize()) return;

      final records = await _accessedAt.list();
      if (records.isEmpty) return;
      final record = records.first;

      final model = record['model'] as String;
      final key = record['key'] as String;
      await _modelData.delete(model: model, key: key);
    });
  }

  Future<void> initOfflineDatabase() async {
    final db = await OfflineDatabase.instance.db();
    _accessedAt = AccessedAt(db);
    _cacheSize = CacheSize(db);
    _modelData = ModelData(db);
    _queuedWrites = QueuedWrites(db);
  }

  Future<void> processWriteQueue(Caller call, {Function? onError}) async {
    if (!isOnline.value) return;
    final queuedWrites = await _queuedWrites.list();
    for (final queuedWrite in queuedWrites) {
      try {
        final method = HttpMethod.values
            .where((v) => v.name() == queuedWrite.method)
            .first;

        final params = withCacheParams(
          CallParams(
            method,
            queuedWrite.path,
            headers: queuedWrite.headers,
            params: queuedWrite.params,
          ),
          CacheParams(
            model: queuedWrite.cacheModel,
            key: queuedWrite.cacheKey,
            responseContainerKey: queuedWrite.cacheResponseContainerKey,
            responseIdKey: queuedWrite.cacheResponseIdKey,
          ),
        );
        final res = await call(params);

        if (method == HttpMethod.post) {
          await _modelData.upsert(
            model: queuedWrite.cacheModel,
            data: res.data,
            key: queuedWrite.cacheKey,
          );
        }
        await _queuedWrites.delete(queuedWrite.key);
      } on AppwriteException catch (e) {
        if (onError != null) {
          onError(e);
        }
        if ((e.code ?? 0) >= 400) {
          await _queuedWrites.delete(queuedWrite.key);
          // restore cache
          if (queuedWrite.previous != null) {
            await _modelData.upsert(
              model: queuedWrite.cacheModel,
              data: queuedWrite.previous!,
              key: queuedWrite.cacheKey,
            );
          }
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
    try {
      final url = Uri.parse('https://appwrite.io/version');
      await http.head(url).timeout(Duration(seconds: 1));
      isOnline.value = true;
    } catch (_) {
      isOnline.value = false;
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
    required Caller call,
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

    if (method == HttpMethod.get) {
      if (cacheKey.isNotEmpty) {
        final record = await _modelData.get(model: cacheModel, key: cacheKey);
        if (record == null) {
          throw AppwriteException(
            "Client is offline and data is not cached",
            0,
            "general_offline",
          );
        }
        _accessedAt.update(model: cacheModel, keys: [cacheKey]);
        return Response(data: record);
      } else {
        final data = await _modelData.list(
          model: cacheModel,
          cacheResponseContainerKey: cacheResponseContainerKey,
          params: params,
        );
        return Response(data: data);
      }
    }
    switch (method) {
      case HttpMethod.get:
        // already handled
        break;
      case HttpMethod.post:
        if (params.containsKey('data')) {
          final documentId = params['documentId'];
          cacheKey = documentId;
          final document = Map<String, dynamic>.from(params['data']);
          final now = DateTime.now().toUtc().toIso8601String();
          document['\$createdAt'] = now;
          document['\$updatedAt'] = now;
          document['\$id'] = documentId;
          document['\$collectionId'] = pathSegments[4];
          document['\$databaseId'] = pathSegments[2];
          document['\$permissions'] = params['permissions'] ?? [];

          await _modelData.upsert(
            model: cacheModel,
            key: cacheKey,
            data: document,
          );
          queuedWriteKey = await _queuedWrites.add(
            method: method,
            path: path,
            headers: headers,
            params: params,
            cacheModel: cacheModel,
            cacheKey: cacheKey,
            cacheResponseIdKey: cacheResponseIdKey,
            cacheResponseContainerKey: cacheResponseContainerKey,
            previous: null,
          );
        }
        break;
      case HttpMethod.delete:
        if (cacheKey.isNotEmpty) {
          final previous = await _modelData.get(
            model: cacheModel,
            key: cacheKey,
          );
          await _modelData.delete(
            model: cacheModel,
            key: cacheKey,
          );
          queuedWriteKey = await _queuedWrites.add(
            method: method,
            path: path,
            headers: headers,
            params: params,
            cacheModel: cacheModel,
            cacheKey: cacheKey,
            cacheResponseIdKey: cacheResponseIdKey,
            cacheResponseContainerKey: cacheResponseContainerKey,
            previous: previous,
          );
        }
        break;
      case HttpMethod.put:
      case HttpMethod.patch:
        final entry = Map<String, dynamic>();
        if (params.containsKey('data')) {
          entry.addAll(Map<String, dynamic>.from(params['data']));
          final now = DateTime.now().toUtc().toIso8601String();
          entry['\$createdAt'] = now;
          entry['\$updatedAt'] = now;
          entry['\$id'] = cacheKey;
        } else if (params.containsKey('prefs')) {
          entry.addAll(Map<String, dynamic>.from(params['prefs']));
        }
        final previous = await _modelData.get(
          model: cacheModel,
          key: cacheKey,
        );
        if (previous != null && previous.containsKey('\$createdAt')) {
          entry['\$createdAt'] = previous['\$createdAt'];
        }
        await _modelData.upsert(
          model: cacheModel,
          key: cacheKey,
          data: entry,
        );
        queuedWriteKey = await _queuedWrites.add(
          method: method,
          path: path,
          headers: headers,
          params: params,
          cacheModel: cacheModel,
          cacheKey: cacheKey,
          cacheResponseIdKey: cacheResponseIdKey,
          cacheResponseContainerKey: cacheResponseContainerKey,
          previous: previous,
        );
        break;
    }
    final completer = Completer<Response>();
    // Declare listener first so it can be referenced inside itself
    Function() listener = () {};
    listener = () async {
      while (true) {
        final queuedWrites = await _queuedWrites.list();

        if (queuedWrites.isEmpty) {
          break;
        }

        if (queuedWrites.first.key != queuedWriteKey) {
          await Future.delayed(Duration.zero);
          continue;
        }

        try {
          final res = await call(CallParams(
            method,
            path,
            headers: headers,
            params: params,
            responseType: responseType,
          ));

          final futures = <Future>[];
          if (method == HttpMethod.post) {
            futures.add(_modelData.upsert(
              model: cacheModel,
              data: res.data,
              key: cacheKey,
            ));
          }
          futures.add(_queuedWrites.delete(queuedWriteKey));

          await Future.wait(futures);

          completer.complete(res);
        } on AppwriteException catch (e) {
          if (e.message == "Bad state: Can't finalize a finalized Request.") {
            continue;
          }
          if (!completer.isCompleted) {
            if (e.code == 404) {
              // delete from cache
              await _modelData.delete(
                model: cacheModel,
                key: cacheKey,
              );
              await _queuedWrites.delete(queuedWriteKey);
            } else if ((e.code ?? 0) >= 400) {
              // restore cache
              final previous = queuedWrites.first.previous;
              if (previous != null) {
                await _modelData.upsert(
                  model: cacheModel,
                  data: previous,
                  key: cacheKey,
                );
              }
              await _queuedWrites.delete(queuedWriteKey);
            }
            completer.completeError(e);
          }
        } catch (e) {
          if (!completer.isCompleted) {
            // restore cache
            final previous = queuedWrites.first.previous;
            if (previous != null) {
              await _modelData.upsert(
                model: cacheModel,
                data: previous,
                key: cacheKey,
              );
            }
            await _queuedWrites.delete(queuedWriteKey);
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

  void cacheResponse({
    required String cacheModel,
    required String cacheKey,
    required String cacheResponseIdKey,
    required http.BaseRequest request,
    required Response response,
  }) {
    if (cacheModel.isEmpty) return;

    switch (request.method) {
      case 'GET':
        final clone = cloneMap(response.data);
        if (cacheKey.isNotEmpty) {
          _modelData.upsert(model: cacheModel, data: clone, key: cacheKey);
        } else {
          clone.forEach((key, value) {
            if (key == 'total') return;
            _modelData.batchUpsert(
              model: cacheModel,
              dataList: value as List,
              idKey: cacheResponseIdKey,
            );
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
        _modelData.upsert(model: cacheModel, data: clone, key: cacheKey);
        break;
      case 'DELETE':
        if (cacheKey.isNotEmpty) {
          _modelData.delete(model: cacheModel, key: cacheKey);
        }
    }
  }
}
