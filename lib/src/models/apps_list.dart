part of '../../models.dart';

/// Apps list
class AppsList implements Model {
  /// Total number of apps that matched your query.
  final int total;

  /// List of apps.
  final List<App> apps;

  AppsList({
    required this.total,
    required this.apps,
  });

  factory AppsList.fromMap(Map<String, dynamic> map) {
    return AppsList(
      total: map['total'],
      apps: List<App>.from(map['apps'].map((p) => App.fromMap(p))),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "total": total,
      "apps": apps.map((p) => p.toMap()).toList(),
    };
  }
}
