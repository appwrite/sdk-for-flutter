import 'dart:io';

import 'package:sembast/sembast.dart';
import 'package:sembast_sqflite/sembast_sqflite.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:sqflite_common_ffi/sqflite_ffi.dart' hide Database;

class OfflineDatabase {
  static final OfflineDatabase instance = OfflineDatabase._internal();
  Database? _db;

  OfflineDatabase._internal();

  Future<Database> db() async {
    if (_db == null) {
      final factory = getDatabaseFactorySqflite(
        Platform.isLinux || Platform.isWindows
            ? databaseFactoryFfi
            : sqflite.databaseFactory,
      );
      _db = await factory.openDatabase('appwrite.db');
    }
    return _db!;
  }
}
