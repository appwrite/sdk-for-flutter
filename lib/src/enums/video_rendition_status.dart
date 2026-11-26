part of '../../enums.dart';

enum VideoRenditionStatus {
  pending(value: "pending"),
  started(value: "started"),
  ended(value: "ended"),
  ready(value: "ready"),
  error(value: "error"),
  aborted(value: "aborted");

  const VideoRenditionStatus({required this.value});

  final String value;

  String toJson() => value;
}
