part of '../../models.dart';

/// AppScope
class AppScope implements Model {
  /// Scope value as requested by apps.
  final String value;

  /// Human-readable description of what the scope grants.
  final String description;

  /// What the scope grants access to. One of `account`, `project`, or `organization`. Only `project` and `organization` scopes are installable.
  final String type;

  /// Scope category, used to group scopes on consent and installation screens.
  final String category;

  /// Whether the scope is deprecated. Deprecated scopes can still be requested but should not be offered for new grants.
  final bool deprecated;

  AppScope({
    required this.value,
    required this.description,
    required this.type,
    required this.category,
    required this.deprecated,
  });
  factory AppScope.fromMap(
    Map<String, dynamic> map,
  ) {
    return AppScope(
      value: map['value'].toString(),
      description: map['description'].toString(),
      type: map['type'].toString(),
      category: map['category'].toString(),
      deprecated: map['deprecated'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "value": value,
      "description": description,
      "type": type,
      "category": category,
      "deprecated": deprecated,
    };
  }
}
