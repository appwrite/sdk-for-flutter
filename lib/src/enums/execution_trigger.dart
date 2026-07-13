part of '../../enums.dart';

enum ExecutionTrigger {
  http(value: 'http'),
  schedule(value: 'schedule'),
  event(value: 'event');

  const ExecutionTrigger({required this.value});

  final String value;

  String toJson() => value;
}
