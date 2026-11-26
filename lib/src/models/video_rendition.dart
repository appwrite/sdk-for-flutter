part of '../../models.dart';

/// Video rendition
class VideoRendition implements Model {
  /// Rendition ID.
  final String $id;

  /// Rendition creation time in ISO 8601 format.
  final String $createdAt;

  /// Rendition update date in ISO 8601 format.
  final String $updatedAt;

  /// Video ID.
  final String videoId;

  /// Video profile ID this rendition was encoded against.
  final String profileId;

  /// Rendition name, derived from its dimensions and bitrate.
  final String name;

  /// Transcoding start time in ISO 8601 format.
  final String startedAt;

  /// Transcoding end time in ISO 8601 format.
  final String endedAt;

  /// Rendition width in pixels.
  final int width;

  /// Rendition height in pixels.
  final int height;

  /// Video bitrate in bits per second.
  final int videoBitRate;

  /// Audio bitrate in bits per second.
  final int audioBitRate;

  /// Longest segment duration in seconds.
  final double targetDuration;

  /// Transcoding status: one of `pending`, `started`, `ended`, `ready`, `error` or `aborted`.
  final enums.VideoRenditionStatus status;

  /// Why the rendition failed or was aborted. Empty unless `status` is `error` or `aborted`.
  final String error;

  /// Transcoding progress as a percentage, from 0 to 100.
  final int progress;

  /// Streaming output format: `hls`, `dash`, or `cmaf`.
  final enums.VideoOutput output;

  /// Video encode codec snapshotted from the profile at create time: one of `h264`, `hevc`, or `vp9`.
  final enums.VideoCodecId codec;

  /// Stored rendition size in bytes.
  final int size;

  VideoRendition({
    required this.$id,
    required this.$createdAt,
    required this.$updatedAt,
    required this.videoId,
    required this.profileId,
    required this.name,
    required this.startedAt,
    required this.endedAt,
    required this.width,
    required this.height,
    required this.videoBitRate,
    required this.audioBitRate,
    required this.targetDuration,
    required this.status,
    required this.error,
    required this.progress,
    required this.output,
    required this.codec,
    required this.size,
  });
  factory VideoRendition.fromMap(
    Map<String, dynamic> map,
  ) {
    map = {
      '\$id': "",
      '\$createdAt': "",
      '\$updatedAt': "",
      'videoId': "",
      'profileId': "",
      'name': "",
      'startedAt': "",
      'endedAt': "",
      'width': 0,
      'height': 0,
      'videoBitRate': 0,
      'audioBitRate': 0,
      'targetDuration': 0,
      'status': "pending",
      'error': "",
      'progress': 0,
      'output': "hls",
      'codec': "h264",
      'size': 0,
      ...map,
    };

    return VideoRendition(
      $id: map['\$id'].toString(),
      $createdAt: map['\$createdAt'].toString(),
      $updatedAt: map['\$updatedAt'].toString(),
      videoId: map['videoId'].toString(),
      profileId: map['profileId'].toString(),
      name: map['name'].toString(),
      startedAt: map['startedAt'].toString(),
      endedAt: map['endedAt'].toString(),
      width: map['width'],
      height: map['height'],
      videoBitRate: map['videoBitRate'],
      audioBitRate: map['audioBitRate'],
      targetDuration: map['targetDuration'].toDouble(),
      status: enums.VideoRenditionStatus.values.firstWhere(
        (e) => e.value == map['status'],
      ),
      error: map['error'].toString(),
      progress: map['progress'],
      output: enums.VideoOutput.values.firstWhere(
        (e) => e.value == map['output'],
      ),
      codec: enums.VideoCodecId.values.firstWhere(
        (e) => e.value == map['codec'],
      ),
      size: map['size'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "\$id": $id,
      "\$createdAt": $createdAt,
      "\$updatedAt": $updatedAt,
      "videoId": videoId,
      "profileId": profileId,
      "name": name,
      "startedAt": startedAt,
      "endedAt": endedAt,
      "width": width,
      "height": height,
      "videoBitRate": videoBitRate,
      "audioBitRate": audioBitRate,
      "targetDuration": targetDuration,
      "status": status.value,
      "error": error,
      "progress": progress,
      "output": output.value,
      "codec": codec.value,
      "size": size,
    };
  }
}
