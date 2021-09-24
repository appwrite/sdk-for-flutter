part of appwrite.models;

/// Continent
class Continent {
    /// Continent name.
    final String name;
    /// Continent two letter code.
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
