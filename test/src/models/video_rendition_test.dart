import 'package:appwrite/models.dart';
import 'package:appwrite/enums.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('VideoRendition', () {
    test('model', () {
      final model = VideoRendition(
        $id: "5e5ea5c16897e",
        $createdAt: "2020-10-15T06:38:00.000+00:00",
        $updatedAt: "2020-10-15T06:38:00.000+00:00",
        videoId: "5e5ea5c16897e",
        profileId: "d5fg5ehg1c168g7c",
        name: "1280X720@3679",
        startedAt: "2020-10-15T06:38:00.000+00:00",
        endedAt: "2020-10-15T06:38:00.000+00:00",
        width: 1280,
        height: 720,
        videoBitRate: 3551000,
        audioBitRate: 128000,
        targetDuration: 6.006,
        status: VideoRenditionStatus.pending,
        error:
            "The requested file is not a valid video or audio file (ffprobe: Invalid data found when processing input)",
        progress: 88,
        output: VideoOutput.hls,
        codec: VideoCodecId.h264,
        size: 18350080,
      );

      final map = model.toMap();
      final result = VideoRendition.fromMap(map);

      expect(result.$id, "5e5ea5c16897e");
      expect(result.$createdAt, "2020-10-15T06:38:00.000+00:00");
      expect(result.$updatedAt, "2020-10-15T06:38:00.000+00:00");
      expect(result.videoId, "5e5ea5c16897e");
      expect(result.profileId, "d5fg5ehg1c168g7c");
      expect(result.name, "1280X720@3679");
      expect(result.startedAt, "2020-10-15T06:38:00.000+00:00");
      expect(result.endedAt, "2020-10-15T06:38:00.000+00:00");
      expect(result.width, 1280);
      expect(result.height, 720);
      expect(result.videoBitRate, 3551000);
      expect(result.audioBitRate, 128000);
      expect(result.targetDuration, 6.006);
      expect(result.status, VideoRenditionStatus.pending);
      expect(
        result.error,
        "The requested file is not a valid video or audio file (ffprobe: Invalid data found when processing input)",
      );
      expect(result.progress, 88);
      expect(result.output, VideoOutput.hls);
      expect(result.codec, VideoCodecId.h264);
      expect(result.size, 18350080);
    });
  });
}
