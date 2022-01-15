part of appwrite.models;

/// Phones List
class PhoneList implements Model {
  /// Total number of items available on the server.
  final int sum;

  /// List of phones.
  final List<Phone> phones;

  PhoneList({
    required this.sum,
    required this.phones,
  });

  factory PhoneList.fromMap(Map<String, dynamic> map) {
    return PhoneList(
      sum: map['sum'],
      phones: List<Phone>.from(map['phones'].map((p) => Phone.fromMap(p))),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "sum": sum,
      "phones": phones.map((p) => p.toMap()),
    };
  }
}
