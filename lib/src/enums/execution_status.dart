part of '../../enums.dart';

enum ExecutionStatus {
  waiting(value: 'waiting'),
  processing(value: 'processing'),
  completed(value: 'completed'),
  failed(value: 'failed');

  const ExecutionStatus({required this.value});

  final String value;

  String toJson() => value;
}
