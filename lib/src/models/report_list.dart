part of '../../models.dart';

/// Reports List
class ReportList implements Model {
    /// Total number of reports that matched your query.
    final int total;

    /// List of reports.
    final List<Report> reports;

    ReportList({
        required this.total,
        required this.reports,
    });

    factory ReportList.fromMap(Map<String, dynamic> map) {
        return ReportList(
            total: map['total'],
            reports: List<Report>.from(map['reports'].map((p) => Report.fromMap(p))),
        );
    }

    @override
    Map<String, dynamic> toMap() {
        return {
            "total": total,
            "reports": reports.map((p) => p.toMap()).toList(),
        };
    }
}
