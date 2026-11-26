part of '../../enums.dart';

enum VideoOutput {
  hls(value: "hls"),
  dash(value: "dash"),
  cmaf(value: "cmaf");

  const VideoOutput({required this.value});

  final String value;

  String toJson() => value;
}
