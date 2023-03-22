import 'package:sembast/sembast.dart';
import 'package:sembast/timestamp.dart';

import '../../enums.dart';
import '../models/queued_write.dart';

class QueuedWrites {
  final Database _db;

  QueuedWrites(this._db);

  StoreRef<String, Map<String, Object?>> _queuedWritesStore =
      stringMapStoreFactory.store('queuedWrites');

  Future<List<QueuedWrite>> list() async {
    final writes = await _queuedWritesStore.find(_db);

    return writes.map((w) {
      final map = Map<String, dynamic>.from(w.value);
      map['key'] = w.key;
      return QueuedWrite.fromMap(map);
    }).toList();
  }

  Future<String> add({
    required HttpMethod method,
    required String path,
    required Map<String, String> headers,
    required Map<String, dynamic> params,
    required String cacheModel,
    required String cacheKey,
    required String cacheResponseIdKey,
    required String cacheResponseContainerKey,
    Map<String, Object?>? previous,
  }) async {
    return _queuedWritesStore.add(_db, {
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

  Future<void> delete(String key) {
    return _queuedWritesStore.record(key).delete(_db);
  }
}
