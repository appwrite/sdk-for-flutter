import 'dart:convert';
import 'src/exception.dart';

class Payload {
  late final String? path;
  late final List<int>? data;
  final String? filename;

  Payload._({this.path, this.filename, this.data}) {
    if (path == null && data == null) {
      throw AppwriteException('One of `path` or `data` is required');
    }
  }

  /// Convert to binary, with optional offset and length
  List<int> toBinary({int offset = 0, int? length}) {
    if(data == null) {
      throw AppwriteException('`data` is not defined.');
    }
    if(offset == 0 && length == null) {
      return data!;
    } else if (length == null) {
      return data!.sublist(offset);
    } else {
      return data!.sublist(offset, offset + length);
    }
  }

  /// Convert binary data to string (utf8)
  @override
  String toString() {
    if(data == null) {
      return '';
    }
    return utf8.decode(data!);
  }

  /// Convert binary data to JSON object
  Map<String, dynamic> toJson() {
    try {
      return jsonDecode(toString()); // Decode the string to JSON
    } catch (e) {
      throw FormatException('Failed to parse JSON: ${e.toString()}');
    }
  }

  /// Create a Payload from binary data
  factory Payload.fromBinary({
    required List<int> data,
    String? filename,
  }) {
    return Payload._(data: data, filename: filename);
  }

  /// Create a Payload from a file
  factory Payload.fromFile({required String path, String? filename}) {
    return Payload._(path: path, filename: filename);
  }

  /// Create a Payload from a JSON object
  factory Payload.fromJson({
    required Map<String, dynamic> data,
    String? filename,
  }) {
    final jsonString = jsonEncode(data);
    return Payload.fromString(string: jsonString, filename: filename);
  }

  /// Create a Payload from a string
  factory Payload.fromString({required String string, String? filename}) {
    final data = utf8.encode(string);
    return Payload._(data: data, filename: filename);
  }
}
