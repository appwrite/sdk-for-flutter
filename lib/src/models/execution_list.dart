part of appwrite.models;

/// Executions List
class ExecutionList implements Model {
    /// Total number of items available on the server.
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

    @override
    Map<String, dynamic> toMap() {
        return {
            "sum": sum,
            "executions": executions.map((p) => p.toMap()),
        };
    }
}
