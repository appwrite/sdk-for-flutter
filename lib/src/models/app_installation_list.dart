part of '../../models.dart';

/// App installations list
class AppInstallationList implements Model {
  /// Total number of installations that matched your query.
  final int total;

  /// List of installations.
  final List<AppInstallation> installations;

  AppInstallationList({
    required this.total,
    required this.installations,
  });

  factory AppInstallationList.fromMap(Map<String, dynamic> map) {
    return AppInstallationList(
      total: map['total'],
      installations: List<AppInstallation>.from(
          map['installations'].map((p) => AppInstallation.fromMap(p))),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "total": total,
      "installations": installations.map((p) => p.toMap()).toList(),
    };
  }
}
