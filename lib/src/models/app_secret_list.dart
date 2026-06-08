part of '../../models.dart';

/// App secrets list
class AppSecretList implements Model {
  /// Total number of secrets that matched your query.
  final int total;

  /// List of secrets.
  final List<AppSecret> secrets;

  AppSecretList({
    required this.total,
    required this.secrets,
  });

  factory AppSecretList.fromMap(Map<String, dynamic> map) {
    return AppSecretList(
      total: map['total'],
      secrets:
          List<AppSecret>.from(map['secrets'].map((p) => AppSecret.fromMap(p))),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "total": total,
      "secrets": secrets.map((p) => p.toMap()).toList(),
    };
  }
}
