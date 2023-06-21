import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:appwrite/src/upload_progress.dart';

void main() {
  group('UploadProgress', () {
    final id = '12345';
    final progress = 0.75;
    final sizeUploaded = 1024;
    final chunksTotal = 10;
    final chunksUploaded = 5;
    final progressMap = {
      "\$id": id,
      "progress": progress,
      "sizeUploaded": sizeUploaded,
      "chunksTotal": chunksTotal,
      "chunksUploaded": chunksUploaded
    };
    final uploadProgress = UploadProgress(
      $id: id,
      progress: progress,
      sizeUploaded: sizeUploaded,
      chunksTotal: chunksTotal,
      chunksUploaded: chunksUploaded,
    );

    test('fromMap should create an instance from a map', () {
      final result = UploadProgress.fromMap(progressMap);

      expect(result.$id, equals(id));
      expect(result.progress, equals(progress));
      expect(result.sizeUploaded, equals(sizeUploaded));
      expect(result.chunksTotal, equals(chunksTotal));
      expect(result.chunksUploaded, equals(chunksUploaded));
    });

    test('toMap should return a map representation of the progress', () {
      final result = uploadProgress.toMap();

      expect(result, equals(progressMap));
    });

    test('toJson and fromJson should convert to/from JSON', () {
      final jsonString = uploadProgress.toJson();

      final result = UploadProgress.fromJson(jsonString);

      expect(result.$id, equals(id));
      expect(result.progress, equals(progress));
      expect(result.sizeUploaded, equals(sizeUploaded));
      expect(result.chunksTotal, equals(chunksTotal));
      expect(result.chunksUploaded, equals(chunksUploaded));
    });

    test('toString should return a string representation of the progress', () {
      final expectedString =
          'UploadProgress(\$id: $id, progress: $progress, sizeUploaded: $sizeUploaded, chunksTotal: $chunksTotal, chunksUploaded: $chunksUploaded)';
      final resultString = uploadProgress.toString();

      expect(resultString, equals(expectedString));
    });

    test('equality operator should compare two instances', () {
      final uploadProgress2 = UploadProgress(
        $id: id,
        progress: progress,
        sizeUploaded: sizeUploaded,
        chunksTotal: chunksTotal,
        chunksUploaded: chunksUploaded,
      );

      expect(uploadProgress == uploadProgress2, isTrue);
    });

    test('hashCode should return a unique hash value', () {
      final hashCode1 = uploadProgress.hashCode;

      final uploadProgress2 = UploadProgress(
        $id: id,
        progress: progress,
        sizeUploaded: sizeUploaded,
        chunksTotal: chunksTotal,
        chunksUploaded: chunksUploaded,
      );
      final hashCode2 = uploadProgress2.hashCode;

      expect(hashCode1, equals(hashCode2));
    });
  });
}
