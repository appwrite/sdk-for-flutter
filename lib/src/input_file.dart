import 'exception.dart';

/// Helper class to handle files.
class InputFile {
  late final String? path;
  late final List<int>? bytes;
  final String? filename;
  final String? contentType;

  @Deprecated('Use `InputFile.fromPath` or `InputFile.fromBytes` instead.')
  InputFile({
    String? path,
    String? filename,
    String? contentType,
    List<int>? bytes,
  }) : this._(
          path: path,
          filename: filename,
          contentType: contentType,
          bytes: bytes,
        );

  InputFile._({this.path, String? filename, this.contentType, this.bytes})
      : filename = filename ?? _filenameFromPath(path) {
    if (path == null && bytes == null) {
      throw AppwriteException('One of `path` or `bytes` is required');
    }
  }

  /// Mirrors how `package:http` derives a filename in `MultipartFile.fromPath`,
  /// so a chunked upload sends the same `filename` as a single-request one.
  /// Without it the chunk parts carry no `filename` and the server rejects them
  /// as an empty file.
  static String? _filenameFromPath(String? path) {
    if (path == null) {
      return null;
    }

    final segments = Uri.file(path).pathSegments;
    final filename = segments.isEmpty ? '' : segments.last;

    return filename.isEmpty ? null : filename;
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
