import 'package:flutter/foundation.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast_sqflite/sembast_sqflite.dart';
import 'package:sembast_web/sembast_web.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

class OfflineDatabase {
  static final OfflineDatabase instance = OfflineDatabase._internal();
  Database? _db;

  OfflineDatabase._internal();

  Future<Database> db() async {
    if (_db == null) {
      final factory = kIsWeb
          ? databaseFactoryWeb
          : getDatabaseFactorySqflite(sqflite.databaseFactory);
      _db = await factory.openDatabase('appwrite.db');
    }
    return _db!;
  }
}
