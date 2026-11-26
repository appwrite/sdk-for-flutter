part of '../../enums.dart';

enum VideoCodecId {
  h264(value: "h264"),
  hevc(value: "hevc"),
  vp9(value: "vp9");

  const VideoCodecId({required this.value});

  final String value;

  String toJson() => value;
}
