part of '../../models.dart';

/// Insight
class Insight implements Model {
    /// Insight ID.
    final String $id;

    /// Insight creation date in ISO 8601 format.
    final String $createdAt;

    /// Insight update date in ISO 8601 format.
    final String $updatedAt;

    /// Parent report ID. Insights always belong to a report.
    final String reportId;

    /// Insight type. One of databaseIndex (legacy), tablesDBIndex, documentsDBIndex, vectorsDBIndex, databasePerformance, sitePerformance, siteAccessibility, siteSeo, functionPerformance. The index types are engine-specific so each CTA can pair the right service+method (databases.createIndex, tablesDB.createIndex, documentsDB.createIndex, or vectorsDB.createIndex).
    final String type;

    /// Insight severity. One of info, warning, critical.
    final String severity;

    /// Insight status. One of active, dismissed.
    final String status;

    /// Type of the resource the insight is about. Plural noun, e.g. databases, sites, functions.
    final String resourceType;

    /// ID of the resource the insight is about.
    final String resourceId;

    /// Plural noun for the parent resource that contains the insight&#039;s resource, e.g. an insight about a column index on a table → resourceType=indexes, parentResourceType=tables. Empty when the resource has no parent.
    final String parentResourceType;

    /// ID of the parent resource. Empty when the resource has no parent.
    final String parentResourceId;

    /// Insight title.
    final String title;

    /// Short markdown summary describing the insight.
    final String summary;

    /// List of call-to-action buttons attached to this insight.
    final List<InsightCTA> ctas;

    /// Time the insight was analyzed in ISO 8601 format.
    final String? analyzedAt;

    /// Time the insight was dismissed in ISO 8601 format. Empty when not dismissed.
    final String? dismissedAt;

    /// User ID that dismissed the insight. Empty when not dismissed.
    final String? dismissedBy;

    Insight({
        required this.$id,
        required this.$createdAt,
        required this.$updatedAt,
        required this.reportId,
        required this.type,
        required this.severity,
        required this.status,
        required this.resourceType,
        required this.resourceId,
        required this.parentResourceType,
        required this.parentResourceId,
        required this.title,
        required this.summary,
        required this.ctas,
        this.analyzedAt,
        this.dismissedAt,
        this.dismissedBy,
    });

    factory Insight.fromMap(Map<String, dynamic> map) {
        return Insight(
            $id: map['\$id'].toString(),
            $createdAt: map['\$createdAt'].toString(),
            $updatedAt: map['\$updatedAt'].toString(),
            reportId: map['reportId'].toString(),
            type: map['type'].toString(),
            severity: map['severity'].toString(),
            status: map['status'].toString(),
            resourceType: map['resourceType'].toString(),
            resourceId: map['resourceId'].toString(),
            parentResourceType: map['parentResourceType'].toString(),
            parentResourceId: map['parentResourceId'].toString(),
            title: map['title'].toString(),
            summary: map['summary'].toString(),
            ctas: List<InsightCTA>.from(map['ctas'].map((p) => InsightCTA.fromMap(p))),
            analyzedAt: map['analyzedAt']?.toString(),
            dismissedAt: map['dismissedAt']?.toString(),
            dismissedBy: map['dismissedBy']?.toString(),
        );
    }

    @override
    Map<String, dynamic> toMap() {
        return {
            "\$id": $id,
            "\$createdAt": $createdAt,
            "\$updatedAt": $updatedAt,
            "reportId": reportId,
            "type": type,
            "severity": severity,
            "status": status,
            "resourceType": resourceType,
            "resourceId": resourceId,
            "parentResourceType": parentResourceType,
            "parentResourceId": parentResourceId,
            "title": title,
            "summary": summary,
            "ctas": ctas.map((p) => p.toMap()).toList(),
            "analyzedAt": analyzedAt,
            "dismissedAt": dismissedAt,
            "dismissedBy": dismissedBy,
        };
    }
}
