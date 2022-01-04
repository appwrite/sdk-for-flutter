part of appwrite.models;

/// Logs List
class LogList implements Model {
    /// Total number of items available on the server.
    final int sum;
    /// List of logs.
    final List<Log> logs;

    LogList({
        required this.sum,
        required this.logs,
    });

    factory LogList.fromMap(Map<String, dynamic> map) {
        return LogList(
            sum: map['sum'],
            logs: List<Log>.from(map['logs'].map((p) => Log.fromMap(p))),
        );
    }

    @override
    Map<String, dynamic> toMap() {
        return {
            "sum": sum,
            "logs": logs.map((p) => p.toMap()),
        };
    }
}
