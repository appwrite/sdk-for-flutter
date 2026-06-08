part of '../../models.dart';

/// Locale codes list
class LocaleCodeList implements Model {
  /// Total number of localeCodes that matched your query.
  final int total;

  /// List of localeCodes.
  final List<LocaleCode> localeCodes;

  LocaleCodeList({
    required this.total,
    required this.localeCodes,
  });

  factory LocaleCodeList.fromMap(Map<String, dynamic> map) {
    return LocaleCodeList(
      total: map['total'],
      localeCodes: List<LocaleCode>.from(
          map['localeCodes'].map((p) => LocaleCode.fromMap(p))),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "total": total,
      "localeCodes": localeCodes.map((p) => p.toMap()).toList(),
    };
  }
}
