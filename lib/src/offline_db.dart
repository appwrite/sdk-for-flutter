import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class OfflineDatabase {
  static final OfflineDatabase instance = OfflineDatabase._internal();
  Database? _db;

  OfflineDatabase._internal();

  Future<Database> db() async {
    if (_db == null) {
      // get the application documents directory
      final dir = await getApplicationDocumentsDirectory();
      // make sure it exists
      await dir.create(recursive: true);
      // build the database path
      final dbPath = join(dir.path, 'appwrite.db');
      // open the database
      _db = await databaseFactoryIo.openDatabase(dbPath);
    }
    return _db!;
  }
}
