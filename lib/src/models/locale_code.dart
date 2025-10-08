part of '../../models.dart';

/// LocaleCode
class LocaleCode implements Model {
    /// Locale codes in [ISO 639-1](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes)
    final String code;

    /// Locale name
    final String name;

    LocaleCode({
        required this.code,
        required this.name,
    });

    factory LocaleCode.fromMap(Map<String, dynamic> map) {
        return LocaleCode(
            code: map['code'].toString(),
            name: map['name'].toString(),
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "code": code,
            "name": name,
        };
    }
}
