import 'dart:convert';

import 'package:sembast/sembast.dart';

class CacheSize {
  final Database _db;

  StoreRef<String, int> _cacheSizeStore = StoreRef<String, int>('cacheSize');

  CacheSize(this._db);

  RecordRef<String, int> getCacheSizeRecordRef() {
    return _cacheSizeStore.record('cacheSize');
  }

  String encode(Map map) {
    final encoded =
        jsonEncode(sembastCodecDefault.jsonEncodableCodec.encode(map));
    return encoded;
  }

  Future<int?> applyChange(Transaction txn, int change) async {
    if (change == 0) return null;

    final record = getCacheSizeRecordRef();
    final currentSize = await record.get(txn) ?? 0;
    return await record.put(txn, currentSize + change);
  }

  Future<void> update({
    required RecordRef<String, Map<String, Object?>> recordRef,
    required Transaction txn,
    Map<String, dynamic>? newData,
  }) async {
    final oldData = await recordRef.get(txn);
    final oldSize = oldData != null ? encode(oldData).length : 0;
    final newSize = newData != null ? encode(newData).length : 0;
    final change = newSize - oldSize;
    final cacheSize = await applyChange(txn, change);

    if (change != 0) {
      print([
        '${recordRef.key}: oldSize: $oldSize',
        'newSize: $newSize',
        'change: $change',
        'cacheSize: $cacheSize',
      ].join(', '));
    }
  }

  void onChange(void callback(int? currentSize)) {
    getCacheSizeRecordRef().onSnapshot(_db).listen((event) {
      callback(event?.value);
    });
  }
}
