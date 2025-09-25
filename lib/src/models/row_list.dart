part of '../../models.dart';

/// Rows List
class RowList implements Model {
  /// Total number of rows that matched your query.
  final int total;

  /// List of rows.
  final List<Row> rows;

  RowList({required this.total, required this.rows});

  factory RowList.fromMap(Map<String, dynamic> map) {
    return RowList(
      total: map['total'],
      rows: List<Row>.from(map['rows'].map((p) => Row.fromMap(p))),
    );
  }

  Map<String, dynamic> toMap() {
    return {"total": total, "rows": rows.map((p) => p.toMap()).toList()};
  }

  List<T> convertTo<T>(T Function(Map) fromJson) =>
      rows.map((d) => d.convertTo<T>(fromJson)).toList();
}
