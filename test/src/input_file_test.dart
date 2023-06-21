import 'package:flutter_test/flutter_test.dart';
import 'package:appwrite/src/exception.dart';
import 'package:appwrite/src/input_file.dart';

void main() {
  group('InputFile', () {
    test('throws exception when neither path nor bytes are provided', () {
      expect(
        () => InputFile(),
        throwsA(isA<AppwriteException>().having(
          (e) => e.message,
          'message',
          'One of `path` or `bytes` is required',
        )),
      );
    });

    test('throws exception when path and bytes are both null', () {
      expect(
        () => InputFile(path: null, bytes: null),
        throwsA(isA<AppwriteException>().having(
          (e) => e.message,
          'message',
          'One of `path` or `bytes` is required',
        )),
      );
    });

    test('creates InputFile from path', () {
      final inputFile = InputFile.fromPath(path: '/path/to/file');

      expect(inputFile.path, '/path/to/file');
      expect(inputFile.filename, isNull);
      expect(inputFile.contentType, isNull);
      expect(inputFile.bytes, isNull);
    });

    test('creates InputFile from bytes', () {
      final inputFile = InputFile.fromBytes(bytes: [1, 2, 3], filename: 'file.txt');

      expect(inputFile.path, isNull);
      expect(inputFile.filename, 'file.txt');
      expect(inputFile.contentType, isNull);
      expect(inputFile.bytes, [1, 2, 3]);
    });
  });
}
