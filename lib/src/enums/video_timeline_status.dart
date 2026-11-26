part of '../../enums.dart';

enum VideoTimelineStatus {
  pending(value: "pending"),
  started(value: "started"),
  ready(value: "ready"),
  skipped(value: "skipped"),
  error(value: "error");

  const VideoTimelineStatus({required this.value});

  final String value;

  String toJson() => value;
}
