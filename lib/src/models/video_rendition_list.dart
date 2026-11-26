part of '../../models.dart';

/// Video Renditions List
class VideoRenditionList implements Model {
  /// Total number of renditions that matched your query.
  final int total;

  /// List of renditions.
  final List<VideoRendition> renditions;

  VideoRenditionList({
    required this.total,
    required this.renditions,
  });
  factory VideoRenditionList.fromMap(
    Map<String, dynamic> map,
  ) {
    map = {
      'total': 0,
      'renditions': [],
      ...map,
    };

    return VideoRenditionList(
      total: map['total'],
      renditions: List<VideoRendition>.from(
        map['renditions'].map((p) => VideoRendition.fromMap(p)),
      ),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "total": total,
      "renditions": renditions.map((p) => p.toMap()).toList(),
    };
  }
}
