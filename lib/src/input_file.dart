import 'exception.dart';

class InputFile {
  late final String? path;
  late final List<int>? bytes;
  final String? filename;
  final String? contentType;

  /// Provide a file, use `path` for IO platforms
  /// and provide `bytes` for web platform
  InputFile({this.path, this.filename, this.contentType, this.bytes}) {
    if (path == null && bytes == null) {
      throw AppwriteException('One of `path` or `bytes`  is required');
    }
  }
}
