import 'package:appwrite/src/offline/services/cache_size.dart';
import 'package:sembast/sembast.dart';

import '../../../appwrite.dart';
import 'accessed_at.dart';

class ModelData {
  final Database _db;
  final AccessedAt _accessedAt;
  final CacheSize _cacheSize;

  ModelData(this._db)
      : _accessedAt = AccessedAt(_db),
        _cacheSize = CacheSize(_db);

  StoreRef<String, Map<String, Object?>> getModelStore(String model) {
    return stringMapStoreFactory.store(model);
  }

  Future<Map<String, dynamic>?> get({
    required String model,
    required String key,
  }) async {
    final store = getModelStore(model);
    final recordRef = store.record(key);
    return recordRef.get(_db);
  }

  Future<Map<String, dynamic>> list({
    required String model,
    required String cacheResponseContainerKey,
    Map<String, dynamic> params = const {},
  }) async {
    final finder = Finder();
    Filter? filter;
    final List<Filter> filters = [];
    final List<SortOrder> sortOrders = [];
    final store = getModelStore(model);

    if (params.containsKey('queries')) {
      final queries = params['queries'] as List<dynamic>;
      queries.forEach((query) {
        final q = Query.parse(query as String);

        switch (q.method) {
          case 'equal':
            final value = q.params[1];
            if (value is List) {
              value.forEach((v) {
                final List<Filter> equalFilters = [];
                value.forEach((v) {
                  equalFilters.add(Filter.equals(q.params[0], v));
                });
                filters.add(Filter.or(equalFilters));
              });
            } else {
              filters.add(Filter.equals(q.params[0], q.params[1]));
            }
            break;

          case 'notEqual':
            filters.add(Filter.notEquals(q.params[0], q.params[1]));
            break;

          case 'lessThan':
            filters.add(Filter.lessThan(q.params[0], q.params[1]));
            break;

          case 'lessThanEqual':
            filters.add(Filter.lessThanOrEquals(q.params[0], q.params[1]));
            break;

          case 'greaterThan':
            filters.add(Filter.greaterThan(q.params[0], q.params[1]));
            break;

          case 'greaterThanEqual':
            filters.add(Filter.greaterThanOrEquals(q.params[0], q.params[1]));
            break;

          case 'search':
            filters.add(Filter.matches(q.params[0], r'${q.params[1]}+'));
            break;

          case 'orderAsc':
            sortOrders.add(SortOrder(q.params[0] as String));
            break;

          case 'orderDesc':
            sortOrders.add(SortOrder(q.params[0] as String, false));
            break;

          case 'cursorBefore':
            // TODO: Handle this case.
            break;

          case 'cursorAfter':
            // TODO: Handle this case.
            break;

          case 'limit':
            finder.limit = q.params[0] as int;
            break;
          case 'offset':
            finder.offset = q.params[0] as int;
            break;
        }
      });

      if (filters.isNotEmpty) {
        filter = Filter.and(filters);
        finder.filter = filter;
      }
    }

    final records = await store.find(_db, finder: finder);
    final count = await store.count(_db, filter: filter);

    final keys = records.map((record) => record.key).toList();

    _accessedAt.update(model: store.name, keys: keys);

    return {
      'total': count,
      cacheResponseContainerKey: records.map((record) {
        final map = Map<String, dynamic>();
        record.value.entries.forEach((entry) {
          map[entry.key] = entry.value;
        });
        return map;
      }).toList(),
    };
  }

  Future<Map<String, Object?>> upsert({
    required String model,
    required Map<String, dynamic> data,
    required String key,
  }) async {
    final store = getModelStore(model);

    final recordRef = store.record(key);
    final record = await recordRef.get(_db);
    _cacheSize.update(oldData: record, newData: data);

    final result = await recordRef.put(_db, data, merge: true);
    await _accessedAt.update(model: model, keys: [key]);
    return result;
  }

  Future<void> batchUpsert({
    required String model,
    required List dataList,
    required String idKey,
  }) {
    final List<Future> futures = [];

    for (final data in dataList) {
      final map = data as Map<String, dynamic>;
      final id = map[idKey];
      futures.add(upsert(model: model, data: map, key: id));
    }

    return Future.wait(futures);
  }

  Future<void> delete({required String model, required String key}) async {
    final store = getModelStore(model);
    RecordSnapshot<String, Map<String, Object?>>? record;

    record = await store.record(key).getSnapshot(_db);

    if (record == null) {
      return;
    }

    _cacheSize.update(oldData: record.value);

    await record.ref.delete(_db);

    await _accessedAt.delete(model: model, key: record.key);
  }
}
