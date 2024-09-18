part of '../../models.dart';

/// Identities List
class IdentityList implements Model {
    /// Total number of identities documents that matched your query.
    final int total;
    /// List of identities.
    final List<Identity> identities;

    IdentityList({
        required this.total,
        required this.identities,
    });

    factory IdentityList.fromMap(Map<String, dynamic> map) {
        return IdentityList(
            total: (map['total'] is String) ?
                        int.tryParse(map['total']) ?? 0:map['total'] ?? 0,
            identities: List<Identity>.from(map['identities'].map((p) => Identity.fromMap(p))),
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "total": total,
            "identities": identities.map((p) => p.toMap()).toList(),
        };
    }
}
