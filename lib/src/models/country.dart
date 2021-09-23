part of appwrite.models;

class Country {
    final String name;
    final String code;

    Country({
        required this.name,
        required this.code,
    });

    factory Country.fromMap(Map<String, dynamic> map) {
        return Country(
            name: map['name'],
            code: map['code'],
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "name": name,
            "code": code,
        };
    }
}
