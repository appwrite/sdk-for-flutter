part of '../../models.dart';

/// Country
class Country implements Model {
    /// Country name.
    final String name;

    /// Country two-character ISO 3166-1 alpha code.
    final String code;

    Country({
        required this.name,
        required this.code,
    });

    factory Country.fromMap(Map<String, dynamic> map) {
        return Country(
            name: map['name'].toString(),
            code: map['code'].toString(),
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "name": name,
            "code": code,
        };
    }
}
