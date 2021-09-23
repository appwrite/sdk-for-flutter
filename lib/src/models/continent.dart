part of appwrite.models;

class Continent {
    final String name;
    final String code;

    Continent({
        required this.name,
        required this.code,
    });

    factory Continent.fromMap(Map<String, dynamic> map) {
        return Continent(
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
