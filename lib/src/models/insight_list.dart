part of '../../models.dart';

/// Insights List
class InsightList implements Model {
  /// Total number of insights that matched your query.
  final int total;

  /// List of insights.
  final List<Insight> insights;

  InsightList({
    required this.total,
    required this.insights,
  });

  factory InsightList.fromMap(Map<String, dynamic> map) {
    return InsightList(
      total: map['total'],
      insights:
          List<Insight>.from(map['insights'].map((p) => Insight.fromMap(p))),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "total": total,
      "insights": insights.map((p) => p.toMap()).toList(),
    };
  }
}
