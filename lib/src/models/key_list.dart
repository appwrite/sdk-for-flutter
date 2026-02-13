part of '../../models.dart';

/// API Keys List
class KeyList implements Model {
  /// Total number of keys that matched your query.
  final int total;

  /// List of keys.
  final List<Key> keys;

  KeyList({
    required this.total,
    required this.keys,
  });

  factory KeyList.fromMap(Map<String, dynamic> map) {
    return KeyList(
      total: map['total'],
      keys: List<Key>.from(map['keys'].map((p) => Key.fromMap(p))),
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
