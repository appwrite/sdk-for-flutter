part of '../../models.dart';

/// Video
class Video implements Model {
  /// Video ID.
  final String $id;

  /// Video creation time in ISO 8601 format.
  final String $createdAt;

  /// Video update date in ISO 8601 format.
  final String $updatedAt;

  /// Video permissions. [Learn more about permissions](https://appwrite.io/docs/permissions).
  final List<String> $permissions;

  /// Storage bucket ID holding the source file.
  final String bucketId;

  /// Source file ID.
  final String fileId;

  /// Video name.
  final String name;

  /// Source file size in bytes.
  final int size;

  /// Container format.
  final String format;

  /// Video duration in milliseconds.
  final int duration;

  /// Video width in pixels.
  final int width;

  /// Video height in pixels.
  final int height;

  /// Video aspect ratio.
  final String aspectRatio;

  /// Video codec.
  final String videoCodec;

  /// Video format.
  final String videoFormat;

  /// Video format profile.
  final String videoFormatProfile;

  /// Video bitrate in bits per second.
  final int videoBitRate;

  /// Video frame rate in frames per second.
  final double videoFrameRate;

  /// Video frame rate mode.
  final String videoFrameRateMode;

  /// Audio codec.
  final String audioCodec;

  /// Audio format.
  final String audioFormat;

  /// Audio bitrate in bits per second.
  final int audioBitRate;

  /// Audio sample rate in hertz.
  final int audioSampleRate;

  /// Thumbnail timeline job status: one of `pending`, `started`, `ready`, `skipped` (source has no video track) or `error`.
  final enums.VideoTimelineStatus timelineStatus;

  /// Why the timeline job failed. Empty unless `timelineStatus` is `error`.
  final String timelineError;

  Video({
    required this.$id,
    required this.$createdAt,
    required this.$updatedAt,
    required this.$permissions,
    required this.bucketId,
    required this.fileId,
    required this.name,
    required this.size,
    required this.format,
    required this.duration,
    required this.width,
    required this.height,
    required this.aspectRatio,
    required this.videoCodec,
    required this.videoFormat,
    required this.videoFormatProfile,
    required this.videoBitRate,
    required this.videoFrameRate,
    required this.videoFrameRateMode,
    required this.audioCodec,
    required this.audioFormat,
    required this.audioBitRate,
    required this.audioSampleRate,
    required this.timelineStatus,
    required this.timelineError,
  });
  factory Video.fromMap(
    Map<String, dynamic> map,
  ) {
    map = {
      '\$id': "",
      '\$createdAt': "",
      '\$updatedAt': "",
      '\$permissions': [],
      'bucketId': "",
      'fileId': "",
      'name': "",
      'size': 0,
      'format': "",
      'duration': 0,
      'width': 0,
      'height': 0,
      'aspectRatio': "",
      'videoCodec': "",
      'videoFormat': "",
      'videoFormatProfile': "",
      'videoBitRate': 0,
      'videoFrameRate': 0,
      'videoFrameRateMode': "",
      'audioCodec': "",
      'audioFormat': "",
      'audioBitRate': 0,
      'audioSampleRate': 0,
      'timelineStatus': "pending",
      'timelineError': "",
      ...map,
    };

    return Video(
      $id: map['\$id'].toString(),
      $createdAt: map['\$createdAt'].toString(),
      $updatedAt: map['\$updatedAt'].toString(),
      $permissions: List.from(map['\$permissions'] ?? []),
      bucketId: map['bucketId'].toString(),
      fileId: map['fileId'].toString(),
      name: map['name'].toString(),
      size: map['size'],
      format: map['format'].toString(),
      duration: map['duration'],
      width: map['width'],
      height: map['height'],
      aspectRatio: map['aspectRatio'].toString(),
      videoCodec: map['videoCodec'].toString(),
      videoFormat: map['videoFormat'].toString(),
      videoFormatProfile: map['videoFormatProfile'].toString(),
      videoBitRate: map['videoBitRate'],
      videoFrameRate: map['videoFrameRate'].toDouble(),
      videoFrameRateMode: map['videoFrameRateMode'].toString(),
      audioCodec: map['audioCodec'].toString(),
      audioFormat: map['audioFormat'].toString(),
      audioBitRate: map['audioBitRate'],
      audioSampleRate: map['audioSampleRate'],
      timelineStatus: enums.VideoTimelineStatus.values.firstWhere(
        (e) => e.value == map['timelineStatus'],
      ),
      timelineError: map['timelineError'].toString(),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "\$id": $id,
      "\$createdAt": $createdAt,
      "\$updatedAt": $updatedAt,
      "\$permissions": $permissions,
      "bucketId": bucketId,
      "fileId": fileId,
      "name": name,
      "size": size,
      "format": format,
      "duration": duration,
      "width": width,
      "height": height,
      "aspectRatio": aspectRatio,
      "videoCodec": videoCodec,
      "videoFormat": videoFormat,
      "videoFormatProfile": videoFormatProfile,
      "videoBitRate": videoBitRate,
      "videoFrameRate": videoFrameRate,
      "videoFrameRateMode": videoFrameRateMode,
      "audioCodec": audioCodec,
      "audioFormat": audioFormat,
      "audioBitRate": audioBitRate,
      "audioSampleRate": audioSampleRate,
      "timelineStatus": timelineStatus.value,
      "timelineError": timelineError,
    };
  }
}
