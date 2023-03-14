import 'package:sembast/sembast.dart';

class OfflineDatabase {
  static final OfflineDatabase instance = OfflineDatabase._internal();
  Database? _db;

  OfflineDatabase._internal();

  Future<Database> db() async {
    throw UnimplementedError();
  }
}
