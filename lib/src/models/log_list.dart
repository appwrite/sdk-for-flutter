part of appwrite.models;

/// Logs List
class LogList implements Model {
  /// Total number of logs documents that matched your query.
  final int total;

  /// List of logs.
  final List<Log> logs;

  LogList({
    required this.total,
    required this.logs,
  });

  factory LogList.fromMap(Map<String, dynamic> map) {
    return LogList(
      total: map['total'],
      logs: List<Log>.from(map['logs'].map((p) => Log.fromMap(p))),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "total": total,
      "logs": logs.map((p) => p.toMap()),
    };
  }
}
