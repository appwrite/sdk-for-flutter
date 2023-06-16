import 'package:appwrite/src/offline/services/cache_size.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/utils/value_utils.dart';

import '../../../appwrite.dart';
import 'accessed_at.dart';

class ModelData {
  final Database _db;
  final AccessedAt _accessedAt;
  final CacheSize _cacheSize;
  final int maxDepth = 3;
  final documentModelRegex = RegExp(
      r'^/databases/([a-zA-Z0-9\-]*)/collections/([a-zA-Z0-9\-]*)/documents$');

  ModelData(this._db)
      : _accessedAt = AccessedAt(_db),
        _cacheSize = CacheSize(_db);

  StoreRef<String, Map<String, Object?>> getModelStore(String model) {
    return stringMapStoreFactory.store(model);
  }

  Future<void> cacheModel(Map<String, dynamic> collection) {
    final store = stringMapStoreFactory.store('collections');

    return store
        .record("${collection['databaseId']}|${collection['collectionId']}")
        .put(_db, collection);
  }

  Future<Map<String, dynamic>?> get({
    required String model,
    required String key,
  }) async {
    final immutableRecord = await _getRecord(model: model, key: key);

    if (immutableRecord == null) return null;

    final record = cloneMap(immutableRecord);
    await _populateRelated(record, 0);

    return record;
  }

  Future<Map<String, dynamic>?> _getRecord({
    required String model,
    required String key,
  }) async {
    final store = getModelStore(model);
    final recordRef = store.record(key);
    return recordRef.get(_db);
  }

  bool _isNestedDocument(Map<String, dynamic> record) {
    return record.containsKey('\$databaseId') &&
        record.containsKey('\$collectionId') &&
        record.containsKey('\$id');
  }

  /// Given a record with $databaseId, $collectionId and $id, populate the rest
  /// of the attributes from the cache and then populate the related records.
  Future<Map<String, dynamic>?> _populateRecord(
      Map<String, dynamic>? record, int depth) async {
    if (record == null) return record;

    if (!_isNestedDocument(record)) return record;

    final databaseId = record['\$databaseId'] as String;
    final collectionId = record['\$collectionId'] as String;
    final documentId = record['\$id'] as String;

    final nestedModel =
        "/databases/$databaseId/collections/$collectionId/documents";

    final cached = await _getRecord(
      model: nestedModel,
      key: documentId,
    );

    if (cached == null) return record;

    record.addAll(cloneMap(cached));

    await _populateRelated(record, depth + 1);

    return record;
  }

  /// Iterate over every attribute of a record and fetch related records from
  /// the cache.
  Future<void> _populateRelated(Map<String, dynamic>? record, int depth) {
    if (record == null) {
      return Future.value();
    }

    // iterate over each attribute and check if it is a relation
    final futures = <Future>[];
    for (final attribute in record.entries) {
      if (attribute.value is Map<String, Object?>) {
        final map = attribute.value as Map<String, Object?>;
        if (_isNestedDocument(record)) {
          if (depth >= maxDepth) {
            record[attribute.key] = null;
          } else {
            final future = _populateRecord(map, depth).then((populated) {
              record[attribute.key] = populated;
            });

            futures.add(future);
          }
        }
      } else if (attribute.value is List) {
        final List list = attribute.value as List;
        final futureList = <Future<Map<String, dynamic>?>>[];
        if (list.isEmpty) continue;

        if (depth >= maxDepth &&
            list.first is Map<String, Object?> &&
            _isNestedDocument(list.first)) {
          record[attribute.key] = [];
          continue;
        }

        for (final map in list) {
          if (map is! Map<String, Object?>) {
            continue;
          }
          futureList.add(_populateRecord(map, depth));
        }

        if (futureList.isEmpty) {
          continue;
        }

        final future = Future.wait(futureList).then((populated) {
          record[attribute.key] = populated;
        });

        futures.add(future);
      }
    }
    return Future.wait(futures);
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
                  equalFilters.add(Filter.equals("${q.params[0]}.\$id", v));
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

          case 'isNull':
            // TODO: Handle this case.
            break;

          case 'isNotNull':
            // TODO: Handle this case.
            break;

          case 'between':
            // TODO: Handle this case.
            break;

          case 'startsWith':
            // TODO: Handle this case.
            break;

          case 'endsWith':
            // TODO: Handle this case.
            break;

          case 'select':
            // TODO: Handle this case.
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

    final list = records.map((record) {
      // convert to Map<String, dynamic>
      final map = Map<String, dynamic>();
      record.value.entries.forEach((entry) {
        map[entry.key] = entry.value;
      });
      return map;
    }).toList();

    final futures = <Future<Map<String, dynamic>?>>[];
    for (final record in list) {
      futures.add(_populateRecord(record, 0));
    }

    final keys = records.map((record) => record.key).toList();

    _accessedAt.update(model: store.name, keys: keys);

    return {
      'total': count,
      cacheResponseContainerKey: await Future.wait(futures),
    };
  }

  Future<Map<String, Object?>> upsert({
    required String model,
    required Map<String, dynamic> data,
    required String key,
  }) async {
    final match = documentModelRegex.firstMatch(model);
    if (match?.groupCount == 2) {
      // data is a document

      // match starting at 1 since 0 is the full match
      final databaseId = match!.group(1)!;
      final collectionId = match.group(2)!;

      final collectionStore = getModelStore('collections');
      final recordRef = collectionStore.record('$databaseId|$collectionId');
      final collection = await recordRef.get(_db);
      final attributes = (collection?['attributes'] ?? <Map<String, Object?>>{})
          as Map<String, Object?>;
      for (final attributeEntry in attributes.entries) {
        final key = attributeEntry.key;
        final attribute = attributeEntry.value as Map<String, Object?>;
        final relatedCollection = attribute['relatedCollection'] as String;
        final relationType = attribute['relationType'] as String;
        final side = attribute['side'] as String;

        if (!data.containsKey(key)) continue;

        final nestedModel =
            "/databases/$databaseId/collections/$relatedCollection/documents";

        if (relationType == 'oneToOne' ||
            (relationType == 'oneToMany' && side == 'child') ||
            (relationType == 'manyToOne' && side == 'parent')) {
          // data[key] is a single document
          String documentId = '';
          if (data[key] is String) {
            // data[key] is a document ID
            documentId = data[key] as String;
          } else if (data[key] is Map<String, Object?>) {
            // data[key] is a nested document
            final related = data[key] as Map<String, Object?>;
            documentId = (related['\$id'] ?? ID.unique()) as String;
            await upsert(model: nestedModel, key: documentId, data: related);
          }
          data[key] = {
            '\$databaseId': databaseId,
            '\$collectionId': relatedCollection,
            '\$id': documentId
          };
        } else {
          // data[key] is a list of documents
          final result = <Map<String, Object?>>[];
          final relatedList = data[key] as List;
          for (final related in relatedList) {
            String documentId = '';
            if (related is String) {
              // related is a document ID
              documentId = related;
            } else if (related is Map<String, Object?>) {
              // related is a nested document
              documentId = (related['\$id'] ?? ID.unique()) as String;
              await upsert(model: nestedModel, key: documentId, data: related);
            }
            result.add({
              '\$databaseId': databaseId,
              '\$collectionId': relatedCollection,
              '\$id': documentId
            });
          }
          data[key] = result;
        }
      }
    }

    final result = await _db.transaction((txn) async {
      final store = getModelStore(model);

      final recordRef = store.record(key);
      final oldData = await recordRef.get(txn);
      final oldSize = oldData != null ? _cacheSize.encode(oldData).length : 0;

      final result = await recordRef.put(txn, data, merge: true);

      final newSize = _cacheSize.encode(result).length;
      final change = newSize - oldSize;

      await _cacheSize.applyChange(txn, change);
      return result;
    });
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
    final recordRef = store.record(key);

    record = await recordRef.getSnapshot(_db);

    if (record == null) {
      return;
    }

    await _db.transaction((txn) async {
      final oldSize = _cacheSize.encode(record!.value).length;
      await _cacheSize.applyChange(txn, oldSize * -1);
      await record.ref.delete(_db);
    });

    await _accessedAt.delete(model: model, key: record.key);
  }
}
