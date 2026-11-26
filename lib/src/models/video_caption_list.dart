part of '../../models.dart';

/// Video Captions List
class VideoCaptionList implements Model {
  /// Total number of captions that matched your query.
  final int total;

  /// List of captions.
  final List<VideoCaption> captions;

  VideoCaptionList({
    required this.total,
    required this.captions,
  });
  factory VideoCaptionList.fromMap(
    Map<String, dynamic> map,
  ) {
    map = {
      'total': 0,
      'captions': [],
      ...map,
    };

    return VideoCaptionList(
      total: map['total'],
      captions: List<VideoCaption>.from(
        map['captions'].map((p) => VideoCaption.fromMap(p)),
      ),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "total": total,
      "captions": captions.map((p) => p.toMap()).toList(),
    };
  }
}
