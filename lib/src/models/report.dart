part of '../../models.dart';

/// Report
class Report implements Model {
  /// Report ID.
  final String $id;

  /// Report creation date in ISO 8601 format.
  final String $createdAt;

  /// Report update date in ISO 8601 format.
  final String $updatedAt;

  /// ID of the third-party app that submitted the report.
  final String appId;

  /// Analyzer that produced this report. e.g. lighthouse, audit, databaseAnalyzer.
  final String type;

  /// Short, human-readable title for the report.
  final String title;

  /// Markdown summary describing the report.
  final String summary;

  /// Plural noun describing what the report analyzes, e.g. databases, sites, urls.
  final String targetType;

  /// Free-form target identifier (URL for lighthouse, resource ID for db).
  final String target;

  /// Categories covered by the report, e.g. performance, accessibility.
  final List<String> categories;

  /// Insights nested under this report.
  final List<Insight> insights;

  /// Time the report was analyzed in ISO 8601 format.
  final String? analyzedAt;

  Report({
    required this.$id,
    required this.$createdAt,
    required this.$updatedAt,
    required this.appId,
    required this.type,
    required this.title,
    required this.summary,
    required this.targetType,
    required this.target,
    required this.categories,
    required this.insights,
    this.analyzedAt,
  });

  factory Report.fromMap(Map<String, dynamic> map) {
    return Report(
      $id: map['\$id'].toString(),
      $createdAt: map['\$createdAt'].toString(),
      $updatedAt: map['\$updatedAt'].toString(),
      appId: map['appId'].toString(),
      type: map['type'].toString(),
      title: map['title'].toString(),
      summary: map['summary'].toString(),
      targetType: map['targetType'].toString(),
      target: map['target'].toString(),
      categories: List.from(map['categories'] ?? []),
      insights:
          List<Insight>.from(map['insights'].map((p) => Insight.fromMap(p))),
      analyzedAt: map['analyzedAt']?.toString(),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "\$id": $id,
      "\$createdAt": $createdAt,
      "\$updatedAt": $updatedAt,
      "appId": appId,
      "type": type,
      "title": title,
      "summary": summary,
      "targetType": targetType,
      "target": target,
      "categories": categories,
      "insights": insights.map((p) => p.toMap()).toList(),
      "analyzedAt": analyzedAt,
    };
  }
}
