part of appwrite.models;

class PhoneList {
    final int sum;
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

    Map<String, dynamic> toMap() {
        return {
            "sum": sum,
            "phones": phones.map((p) => p.toMap()),
        };
    }
}
