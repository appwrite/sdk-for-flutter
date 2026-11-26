part of '../../models.dart';

/// Videos List
class VideoList implements Model {
  /// Total number of videos that matched your query.
  final int total;

  /// List of videos.
  final List<Video> videos;

  VideoList({
    required this.total,
    required this.videos,
  });
  factory VideoList.fromMap(
    Map<String, dynamic> map,
  ) {
    map = {
      'total': 0,
      'videos': [],
      ...map,
    };

    return VideoList(
      total: map['total'],
      videos: List<Video>.from(
        map['videos'].map((p) => Video.fromMap(p)),
      ),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "total": total,
      "videos": videos.map((p) => p.toMap()).toList(),
    };
  }
}
