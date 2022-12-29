import 'dart:convert';
import 'dart:math';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/src/enums.dart';
import 'package:appwrite/src/offline_db.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/timestamp.dart';

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
  bool isOnline = true;
  late Database db;

  StoreRef<String, Map<String, Object?>> _queuedWritesStore =
      stringMapStoreFactory.store('queuedWrites');
  StoreRef<String, Map<String, Object?>> _accessTimestampsStore =
      stringMapStoreFactory.store('accessTimestamps');
  StoreRef<String, int> _cacheSizeStore = StoreRef<String, int>('cacheSize');

  Random _random = Random();

  Future<void> initOfflineDatabase() async {
    db = await OfflineDatabase.instance.db();
  }

  bool resultIsOnline(ConnectivityResult result) {
    return result == ConnectivityResult.mobile ||
        result == ConnectivityResult.ethernet ||
        result == ConnectivityResult.wifi;
  }

  Future<void> listenForConnectivity() async {
    void handleConnectivityResult(ConnectivityResult result) {
      isOnline = resultIsOnline(result);
    }

    final result = await Connectivity().checkConnectivity();
    handleConnectivityResult(result);
    Connectivity().onConnectivityChanged.listen(handleConnectivityResult);
  }

  String getModel(Uri uri) {
    final pathSegments = uri.pathSegments;
    if (pathSegments.length > 5 &&
        pathSegments[1] == 'databases' &&
        pathSegments[3] == 'collections' &&
        pathSegments[5] == 'documents') {
      return '/' + uri.pathSegments.sublist(0, 6).join('/');
    }

    if (pathSegments.length > 2 &&
        pathSegments[1] == 'account' &&
        pathSegments[2] == 'sessions') {
      return '/' + uri.pathSegments.sublist(0, 3).join('/');
    }

    return uri.path;
  }

  String getKey(Uri uri) {
    final pathSegments = uri.pathSegments;
    String key = '';
    if (pathSegments.length == 2 && pathSegments[1] == 'account') {
      key = 'current';
    } else if (pathSegments.length > 6 &&
        pathSegments[1] == 'databases' &&
        pathSegments[3] == 'collections' &&
        pathSegments[5] == 'documents') {
      key = pathSegments[6];
    } else if (pathSegments.length > 3 &&
        pathSegments[1] == 'account' &&
        pathSegments[2] == 'sessions') {
      key = pathSegments[3];
    } else if (pathSegments.length > 2 &&
        pathSegments[1] == 'account' &&
        pathSegments[2] == 'prefs') {
      key = 'current';
    } else if (pathSegments.length == 2 && pathSegments[1] == 'locale') {
      key = 'current';
    }

    return key;
  }

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

  Future<void> upsertCache(DatabaseClient db,
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
      await recordRef.put(db, map);
      await updateAccessedAt(db, store.name, key);
      return;
    }

    final record = await store.findFirst(db,
        finder: Finder(filter: Filter.equals('\$id', id)));

    if (record == null) {
      final encoded = encode(map);
      final change = encoded.length;
      await updateCacheSize(db, change);
      final key = await store.add(db, map);
      await updateAccessedAt(db, store.name, key);
      return;
    }

    final updated = await record.ref.update(db, map);
    if (updated != null) {
      final change = calculateChange(record.value, map);
      await updateCacheSize(db, change);
    }
    await updateAccessedAt(db, store.name, record.key);
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

  Future<String> addQueuedWrite(DatabaseClient db, HttpMethod method,
      String path, Map<String, String> headers, Map<String, dynamic> params) {
    return _queuedWritesStore.add(db, {
      'queuedAt': Timestamp.now(),
      'method': method.name(),
      'path': path,
      'headers': headers,
      'params': params,
    });
  }

  Future<void> deleteQueuedWrite(DatabaseClient db, String key) {
    return _queuedWritesStore.record(key).delete(db);
  }
}
