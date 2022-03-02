import 'dart:convert';

class UploadProgress {
  final String $id;
  final double progress;
  final int sizeUploaded;
  final int chunksTotal;
  final int chunksUploaded;
  UploadProgress({
    required this.$id,
    required this.progress,
    required this.sizeUploaded,
    required this.chunksTotal,
    required this.chunksUploaded,
  });

  factory UploadProgress.fromMap(Map<String, dynamic> map) {
    return UploadProgress(
      $id: map['\$id'] ?? '',
      progress: map['progress']?.toDouble() ?? 0.0,
      sizeUploaded: map['sizeUploaded']?.toInt() ?? 0,
      chunksTotal: map['chunksTotal']?.toInt() ?? 0,
      chunksUploaded: map['chunksUploaded']?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "\$id": $id,
      "progress": progress,
      "sizeUploaded": sizeUploaded,
      "chunksTotal": chunksTotal,
      "chunksUploaded": chunksUploaded
    };
  }

  String toJson() => json.encode(toMap());

  factory UploadProgress.fromJson(String source) =>
      UploadProgress.fromMap(json.decode(source));

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
