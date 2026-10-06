import 'package:flutter_test/flutter_test.dart';
import 'package:appwrite/src/exception.dart';
import 'package:appwrite/src/input_file.dart';

void main() {
  group('InputFile', () {
    test('throws exception when neither path nor bytes are provided', () {
      expect(
        () => InputFile(),
        throwsA(
          isA<AppwriteException>().having(
            (e) => e.message,
            'message',
            'One of `path` or `bytes` is required',
          ),
        ),
      );
    });

    test('throws exception when path and bytes are both null', () {
      expect(
        () => InputFile(path: null, bytes: null),
        throwsA(
          isA<AppwriteException>().having(
            (e) => e.message,
            'message',
            'One of `path` or `bytes` is required',
          ),
        ),
      );
    });

    test('creates InputFile from path', () {
      final inputFile = InputFile.fromPath(path: '/path/to/file');

      expect(inputFile.path, '/path/to/file');
      expect(inputFile.filename, 'file');
      expect(inputFile.contentType, isNull);
      expect(inputFile.bytes, isNull);
    });

    test('derives filename from path when none is given', () {
      expect(
        InputFile.fromPath(path: '/path/to/video.mp4').filename,
        'video.mp4',
        reason: 'chunks of a file over 5MB are sent as bytes, and without a '
            'filename the server rejects them as an empty file',
      );
      expect(InputFile.fromPath(path: './relative/image.png').filename,
          'image.png');
      expect(InputFile.fromPath(path: 'video.mp4').filename, 'video.mp4');
    });

    test('keeps an explicitly provided filename', () {
      final inputFile = InputFile.fromPath(
        path: '/path/to/video.mp4',
        filename: 'renamed.mp4',
      );

      expect(inputFile.filename, 'renamed.mp4');
    });

    test('derives filename from path on the deprecated constructor', () {
      expect(InputFile(path: '/path/to/video.mp4').filename, 'video.mp4');
    });

    test('leaves filename null when the path has no final segment', () {
      expect(InputFile.fromPath(path: '/path/to/').filename, isNull);
    });

    test('creates InputFile from bytes', () {
      final inputFile = InputFile.fromBytes(
        bytes: [1, 2, 3],
        filename: 'file.txt',
      );

      expect(inputFile.path, isNull);
      expect(inputFile.filename, 'file.txt');
      expect(inputFile.contentType, isNull);
      expect(inputFile.bytes, [1, 2, 3]);
    });
  });
}
