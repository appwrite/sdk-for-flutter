part of '../../models.dart';

/// Phone
class Phone implements Model {
  /// Phone code.
  final String code;

  /// Country two-character ISO 3166-1 alpha code.
  final String countryCode;

  /// Country name.
  final String countryName;

  Phone({
    required this.code,
    required this.countryCode,
    required this.countryName,
  });

  factory Phone.fromMap(Map<String, dynamic> map) {
    return Phone(
      code: map['code'].toString(),
      countryCode: map['countryCode'].toString(),
      countryName: map['countryName'].toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "code": code,
      "countryCode": countryCode,
      "countryName": countryName,
    };
  }
}
