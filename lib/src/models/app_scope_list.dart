part of '../../models.dart';

/// App scopes list
class AppScopeList implements Model {
  /// Total number of scopes that matched your query.
  final int total;

  /// List of scopes.
  final List<AppScope> scopes;

  AppScopeList({
    required this.total,
    required this.scopes,
  });
  factory AppScopeList.fromMap(
    Map<String, dynamic> map,
  ) {
    return AppScopeList(
      total: map['total'],
      scopes: List<AppScope>.from(
        map['scopes'].map((p) => AppScope.fromMap(p)),
      ),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "total": total,
      "scopes": scopes.map((p) => p.toMap()).toList(),
    };
  }
}
