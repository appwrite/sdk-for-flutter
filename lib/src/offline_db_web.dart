import 'package:sembast/sembast.dart';
import 'package:sembast_web/sembast_web.dart';

class OfflineDatabase {
  static final OfflineDatabase instance = OfflineDatabase._internal();
  Database? _db;

  OfflineDatabase._internal();

  Future<Database> db() async {
    if (_db == null) {
      final factory = databaseFactoryWeb;
      _db = await factory.openDatabase('appwrite.db');
    }
    return _db!;
  }
}
