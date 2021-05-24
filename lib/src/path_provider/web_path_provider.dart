import 'path_provider.dart';

class PathProviderForWeb extends PathProvider {
  @override
  Future getApplicationDocumentsDirectory() {
    throw UnimplementedError();
  }
}

PathProvider getPathProvider() => PathProviderForWeb();
