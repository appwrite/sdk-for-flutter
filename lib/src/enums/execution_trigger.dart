part of '../../enums.dart';

enum ExecutionTrigger {
  http(value: "http"),
  schedule(value: "schedule"),
  event(value: "event"),
  email(value: "email");

  const ExecutionTrigger({required this.value});

  final String value;

  String toJson() => value;
}
