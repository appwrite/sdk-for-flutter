import 'exception.dart';

/// Helper class to handle files.
class InputFile {
  late final String? path;
  late final List<int>? bytes;
  final String? filename;
  final String? contentType;

  @Deprecated('Use `InputFile.fromPath` or `InputFile.fromBytes` instead.')
  InputFile({this.path, this.filename, this.contentType, this.bytes}) {
    if (path == null && bytes == null) {
      throw AppwriteException('One of `path` or `bytes` is required');
    }
  }

  InputFile._({this.path, this.filename, this.contentType, this.bytes}) {
    if (path == null && bytes == null) {
      throw AppwriteException('One of `path` or `bytes` is required');
    }
  }

  /// Provide a file using `path`
  factory InputFile.fromPath({
    required String path,
    String? filename,
    String? contentType,
  }) {
    return InputFile._(
      path: path,
      filename: filename,
      contentType: contentType,
    );
  }

  /// Provide a file using `bytes`
  factory InputFile.fromBytes({
    required List<int> bytes,
    required String filename,
    String? contentType,
  }) {
    return InputFile._(
      bytes: bytes,
      filename: filename,
      contentType: contentType,
    );
  }
}
