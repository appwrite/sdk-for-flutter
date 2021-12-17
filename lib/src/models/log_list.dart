part of appwrite.models;

/// Logs List
class LogList implements Model {
    /// List of logs.
    final List<Log> logs;

    LogList({
        required this.logs,
    });

    factory LogList.fromMap(Map<String, dynamic> map) {
        return LogList(
            logs: List<Log>.from(map['logs'].map((p) => Log.fromMap(p))),
        );
    }

    @override
    Map<String, dynamic> toMap() {
        return {
            "logs": logs.map((p) => p.toMap()),
        };
    }
}
