import 'dart:io';
import 'path_provider.dart';
import 'package:path_provider/path_provider.dart' as path;

class PathProviderForIO extends PathProvider {
  @override
  Future<Directory> getApplicationDocumentsDirectory() {
    return path.getApplicationDocumentsDirectory();
  }
}

PathProvider getPathProvider() => PathProviderForIO();
