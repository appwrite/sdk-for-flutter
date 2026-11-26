import 'package:appwrite/models.dart';
import 'package:appwrite/enums.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('VideoCaption', () {
    test('model', () {
      final model = VideoCaption(
        $id: "5e5ea5c16897e",
        $createdAt: "2020-10-15T06:38:00.000+00:00",
        $updatedAt: "2020-10-15T06:38:00.000+00:00",
        videoId: "5e5ea5c16897e",
        bucketId: "d5fg5ehg1c168g7c",
        fileId: "c5fg5emg1c168grr",
        name: "English",
        language: "eng",
        xdefault: true,
        embedded: true,
        targetDuration: 93,
        status: VideoCaptionStatus.pending,
        error:
            "Caption is not a proper .srt file (Invalid timestamp delimiter at line 2)",
        size: 4096,
      );

      final map = model.toMap();
      final result = VideoCaption.fromMap(map);

      expect(result.$id, "5e5ea5c16897e");
      expect(result.$createdAt, "2020-10-15T06:38:00.000+00:00");
      expect(result.$updatedAt, "2020-10-15T06:38:00.000+00:00");
      expect(result.videoId, "5e5ea5c16897e");
      expect(result.bucketId, "d5fg5ehg1c168g7c");
      expect(result.fileId, "c5fg5emg1c168grr");
      expect(result.name, "English");
      expect(result.language, "eng");
      expect(result.xdefault, true);
      expect(result.embedded, true);
      expect(result.targetDuration, 93);
      expect(result.status, VideoCaptionStatus.pending);
      expect(
        result.error,
        "Caption is not a proper .srt file (Invalid timestamp delimiter at line 2)",
      );
      expect(result.size, 4096);
    });
  });
}
