part of '../../models.dart';

/// Locale codes list
class LocaleCodeList implements Model {
    /// Total number of localeCodes documents that matched your query.
    final int total;
    /// List of localeCodes.
    final List<LocaleCode> localeCodes;

    LocaleCodeList({
        required this.total,
        required this.localeCodes,
    });

    factory LocaleCodeList.fromMap(Map<String, dynamic> map) {
        return LocaleCodeList(
            total: (map['total'] is String) ?
                        int.tryParse(map['total']) ?? 0:map['total'] ?? 0,
            localeCodes: List<LocaleCode>.from(map['localeCodes'].map((p) => LocaleCode.fromMap(p))),
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "total": total,
            "localeCodes": localeCodes.map((p) => p.toMap()).toList(),
        };
    }
}
