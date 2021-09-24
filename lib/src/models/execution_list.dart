part of appwrite.models;

/// Executions List
class ExecutionList {
    /// Total sum of items in the list.
    final int sum;
    /// List of executions.
    final List<Execution> executions;

    ExecutionList({
        required this.sum,
        required this.executions,
    });

    factory ExecutionList.fromMap(Map<String, dynamic> map) {
        return ExecutionList(
            sum: map['sum'],
            executions: List<Execution>.from(map['executions'].map((p) => Execution.fromMap(p))),
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "sum": sum,
            "executions": executions.map((p) => p.toMap()),
        };
    }
}
