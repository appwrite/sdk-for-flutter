part of '../../models.dart';

/// App keys list
class AppKeyList implements Model {
  /// Total number of keys that matched your query.
  final int total;

  /// List of keys.
  final List<AppKey> keys;

  AppKeyList({
    required this.total,
    required this.keys,
  });
  factory AppKeyList.fromMap(
    Map<String, dynamic> map,
  ) {
    return AppKeyList(
      total: map['total'],
      keys: List<AppKey>.from(
        map['keys'].map((p) => AppKey.fromMap(p)),
      ),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "total": total,
      "keys": keys.map((p) => p.toMap()).toList(),
    };
  }
}
