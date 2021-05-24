import 'path_provider_stub.dart'
    if (dart.library.io) 'io_path_provider.dart'
    if (dart.library.js) 'web_path_provider.dart';

abstract class PathProvider {
  static PathProvider? _instance;
  static PathProvider get instance {
    _instance ??= getPathProvider();
    return _instance!;
  }

  Future getApplicationDocumentsDirectory();
}
