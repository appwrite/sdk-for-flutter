part of '../../models.dart';

/// Executions List
class ExecutionList implements Model {
  /// Total number of executions that matched your query.
  final int total;

  /// List of executions.
  final List<Execution> executions;

  ExecutionList({
    required this.total,
    required this.executions,
  });

  factory ExecutionList.fromMap(Map<String, dynamic> map) {
    return ExecutionList(
      total: map['total'],
      executions: List<Execution>.from(
          map['executions'].map((p) => Execution.fromMap(p))),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "total": total,
      "executions": executions.map((p) => p.toMap()).toList(),
    };
  }
}
