part of '../../models.dart';

/// Phones List
class PhoneList implements Model {
    /// Total number of phones documents that matched your query.
    final int total;
    /// List of phones.
    final List<Phone> phones;

    PhoneList({
        required this.total,
        required this.phones,
    });

    factory PhoneList.fromMap(Map<String, dynamic> map) {
        return PhoneList(
            total: map['total'],
            phones: List<Phone>.from(map['phones'].map((p) => Phone.fromMap(p))),
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "total": total,
            "phones": phones.map((p) => p.toMap()).toList(),
        };
    }
}
