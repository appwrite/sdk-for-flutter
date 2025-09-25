part of '../../models.dart';

/// Continent
class Continent implements Model {
  /// Continent name.
  final String name;

  /// Continent two letter code.
  final String code;

  Continent({required this.name, required this.code});

  factory Continent.fromMap(Map<String, dynamic> map) {
    return Continent(
      name: map['name'].toString(),
      code: map['code'].toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {"name": name, "code": code};
  }
}
