part of appwrite.models;

class ExecutionList {
    late final int sum;
    late final List<Execution> executions;

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
