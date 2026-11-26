import 'package:appwrite/models.dart';
import 'package:appwrite/enums.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Video', () {
    test('model', () {
      final model = Video(
        $id: "5e5ea5c16897e",
        $createdAt: "2020-10-15T06:38:00.000+00:00",
        $updatedAt: "2020-10-15T06:38:00.000+00:00",
        $permissions: [],
        bucketId: "5e5ea5c16897e",
        fileId: "d5fg5ehg1c168g7c",
        name: "Product demo",
        size: 23647142,
        format: "MPEG-4",
        duration: 92810,
        width: 960,
        height: 544,
        aspectRatio: "16:9",
        videoCodec: "h264",
        videoFormat: "AVC",
        videoFormatProfile: "Baseline@L3.1",
        videoBitRate: 564790,
        videoFrameRate: 29.97,
        videoFrameRateMode: "CFR",
        audioCodec: "aac",
        audioFormat: "AAC",
        audioBitRate: 127999,
        audioSampleRate: 48000,
        timelineStatus: VideoTimelineStatus.pending,
        timelineError:
            "The requested file is not a valid video or audio file (ffprobe: Invalid data found when processing input)",
      );

      final map = model.toMap();
      final result = Video.fromMap(map);

      expect(result.$id, "5e5ea5c16897e");
      expect(result.$createdAt, "2020-10-15T06:38:00.000+00:00");
      expect(result.$updatedAt, "2020-10-15T06:38:00.000+00:00");
      expect(result.$permissions, []);
      expect(result.bucketId, "5e5ea5c16897e");
      expect(result.fileId, "d5fg5ehg1c168g7c");
      expect(result.name, "Product demo");
      expect(result.size, 23647142);
      expect(result.format, "MPEG-4");
      expect(result.duration, 92810);
      expect(result.width, 960);
      expect(result.height, 544);
      expect(result.aspectRatio, "16:9");
      expect(result.videoCodec, "h264");
      expect(result.videoFormat, "AVC");
      expect(result.videoFormatProfile, "Baseline@L3.1");
      expect(result.videoBitRate, 564790);
      expect(result.videoFrameRate, 29.97);
      expect(result.videoFrameRateMode, "CFR");
      expect(result.audioCodec, "aac");
      expect(result.audioFormat, "AAC");
      expect(result.audioBitRate, 127999);
      expect(result.audioSampleRate, 48000);
      expect(result.timelineStatus, VideoTimelineStatus.pending);
      expect(
        result.timelineError,
        "The requested file is not a valid video or audio file (ffprobe: Invalid data found when processing input)",
      );
    });
  });
}
