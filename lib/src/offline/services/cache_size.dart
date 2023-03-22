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

  Future<void> applyChange(int change) async {
    if (change == 0) return;

    final record = getCacheSizeRecordRef();

    final currentSize = await record.get(_db) ?? 0;
    await record.put(_db, currentSize + change);
  }

  Future<void> update({
    Map<String, dynamic>? oldData,
    Map<String, dynamic>? newData,
  }) async {
    final oldSize = oldData != null ? encode(oldData).length : 0;
    final newSize = newData != null ? encode(newData).length : 0;
    final change = newSize - oldSize;
    await applyChange(change);
  }

  void onChange(void callback(int? currentSize)) {
    getCacheSizeRecordRef().onSnapshot(_db).listen((event) {
      callback(event?.value);
    });
  }
}
