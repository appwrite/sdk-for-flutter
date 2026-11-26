part of '../../models.dart';

/// Video caption
class VideoCaption implements Model {
  /// Caption ID.
  final String $id;

  /// Caption creation time in ISO 8601 format.
  final String $createdAt;

  /// Caption update date in ISO 8601 format.
  final String $updatedAt;

  /// Video ID.
  final String videoId;

  /// Storage bucket ID holding the caption file.
  final String bucketId;

  /// Caption file ID.
  final String fileId;

  /// Caption display name.
  final String name;

  /// Caption ISO 639-2 language code.
  final String language;

  /// Is this the default caption track?
  final bool xdefault;

  /// Was this track auto-extracted from the source container? Extracted tracks have no backing file; extraction runs once per video, so a deleted extracted track is not re-created.
  final bool embedded;

  /// Longest segment duration in seconds.
  final double targetDuration;

  /// Packaging status: one of `pending`, `started`, `ready`, `error` or `aborted`.
  final enums.VideoCaptionStatus status;

  /// Why the caption failed or was aborted. Empty unless `status` is `error` or `aborted`.
  final String error;

  /// Stored caption size in bytes.
  final int size;

  VideoCaption({
    required this.$id,
    required this.$createdAt,
    required this.$updatedAt,
    required this.videoId,
    required this.bucketId,
    required this.fileId,
    required this.name,
    required this.language,
    required this.xdefault,
    required this.embedded,
    required this.targetDuration,
    required this.status,
    required this.error,
    required this.size,
  });
  factory VideoCaption.fromMap(
    Map<String, dynamic> map,
  ) {
    map = {
      '\$id': "",
      '\$createdAt': "",
      '\$updatedAt': "",
      'videoId': "",
      'bucketId': "",
      'fileId': "",
      'name': "",
      'language': "",
      'default': false,
      'embedded': false,
      'targetDuration': 0,
      'status': "pending",
      'error': "",
      'size': 0,
      ...map,
    };

    return VideoCaption(
      $id: map['\$id'].toString(),
      $createdAt: map['\$createdAt'].toString(),
      $updatedAt: map['\$updatedAt'].toString(),
      videoId: map['videoId'].toString(),
      bucketId: map['bucketId'].toString(),
      fileId: map['fileId'].toString(),
      name: map['name'].toString(),
      language: map['language'].toString(),
      xdefault: map['default'],
      embedded: map['embedded'],
      targetDuration: map['targetDuration'].toDouble(),
      status: enums.VideoCaptionStatus.values.firstWhere(
        (e) => e.value == map['status'],
      ),
      error: map['error'].toString(),
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
      "bucketId": bucketId,
      "fileId": fileId,
      "name": name,
      "language": language,
      "default": xdefault,
      "embedded": embedded,
      "targetDuration": targetDuration,
      "status": status.value,
      "error": error,
      "size": size,
    };
  }
}
