import 'dart:convert';

/// Progress of a File Upload
class UploadProgress {
  /// ID of the file.
  final String $id;

  /// Progress percentage.
  final double progress;

  /// Size uploaded in bytes.
  final int sizeUploaded;

  /// Total number of chunks.
  final int chunksTotal;

  /// Number of chunks uploaded.
  final int chunksUploaded;

  /// Initializes an [UploadProgress]
  UploadProgress({
    required this.$id,
    required this.progress,
    required this.sizeUploaded,
    required this.chunksTotal,
    required this.chunksUploaded,
  });

  /// Initializes an [UploadProgress] from a [Map<String, dynamic>]
  factory UploadProgress.fromMap(Map<String, dynamic> map) {
    return UploadProgress(
      $id: map['\$id'] ?? '',
      progress: map['progress']?.toDouble() ?? 0.0,
      sizeUploaded: map['sizeUploaded']?.toInt() ?? 0,
      chunksTotal: map['chunksTotal']?.toInt() ?? 0,
      chunksUploaded: map['chunksUploaded']?.toInt() ?? 0,
    );
  }

  /// Converts an [UploadProgress] to a [Map<String, dynamic>]
  Map<String, dynamic> toMap() {
    return {
      "\$id": $id,
      "progress": progress,
      "sizeUploaded": sizeUploaded,
      "chunksTotal": chunksTotal,
      "chunksUploaded": chunksUploaded
    };
  }

  /// Converts an [UploadProgress] to a JSON [String]
  String toJson() => json.encode(toMap());

  /// Initializes an [UploadProgress] from a JSON [String]
  factory UploadProgress.fromJson(String source) =>
      UploadProgress.fromMap(json.decode(source));

  /// Returns a string representation of an [UploadProgress]
  @override
  String toString() {
    return 'UploadProgress(\$id: ${$id}, progress: $progress, sizeUploaded: $sizeUploaded, chunksTotal: $chunksTotal, chunksUploaded: $chunksUploaded)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UploadProgress &&
        other.$id == $id &&
        other.progress == progress &&
        other.sizeUploaded == sizeUploaded &&
        other.chunksTotal == chunksTotal &&
        other.chunksUploaded == chunksUploaded;
  }

  @override
  int get hashCode {
    return $id.hashCode ^
        progress.hashCode ^
        sizeUploaded.hashCode ^
        chunksTotal.hashCode ^
        chunksUploaded.hashCode;
  }
}
