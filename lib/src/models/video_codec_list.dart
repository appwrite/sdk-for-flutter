part of '../../models.dart';

/// Video Codecs List
class VideoCodecList implements Model {
  /// Total number of codecs that matched your query.
  final int total;

  /// List of codecs.
  final List<VideoCodec> codecs;

  VideoCodecList({
    required this.total,
    required this.codecs,
  });
  factory VideoCodecList.fromMap(
    Map<String, dynamic> map,
  ) {
    map = {
      'total': 0,
      'codecs': [],
      ...map,
    };

    return VideoCodecList(
      total: map['total'],
      codecs: List<VideoCodec>.from(
        map['codecs'].map((p) => VideoCodec.fromMap(p)),
      ),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "total": total,
      "codecs": codecs.map((p) => p.toMap()).toList(),
    };
  }
}
