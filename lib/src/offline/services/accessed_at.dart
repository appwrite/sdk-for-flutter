import 'package:sembast/sembast.dart';
import 'package:sembast/timestamp.dart';

class AccessedAt {
  final Database _db;

  StoreRef<String, Map<String, Object?>> accessTimestampsStore =
      stringMapStoreFactory.store('accessTimestamps');

  AccessedAt(this._db);

  Future<List<Map<String, Object?>>> list() async {
    final finder = Finder(sortOrders: [SortOrder('accessedAt')]);
    final result = await accessTimestampsStore.find(_db, finder: finder);

    return result.map((e) => e.value).toList();
  }

  Future<void> update({
    required String model,
    required List<String> keys,
  }) async {
    _db.transaction((txn) async {
      for (final key in keys) {
        final value = {
          'model': model,
          'key': key,
          'accessedAt': Timestamp.now(),
        };
        await accessTimestampsStore.record('$model-$key').put(txn, value);
      }
    });
  }

  Future<void> delete({required String model, required String key}) {
    return accessTimestampsStore.record('$model-$key').delete(_db);
  }
}
