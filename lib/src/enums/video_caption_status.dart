part of '../../enums.dart';

enum VideoCaptionStatus {
  pending(value: "pending"),
  started(value: "started"),
  ready(value: "ready"),
  error(value: "error"),
  aborted(value: "aborted");

  const VideoCaptionStatus({required this.value});

  final String value;

  String toJson() => value;
}
