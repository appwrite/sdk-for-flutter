part of appwrite.models;

class Language {
    final String name;
    final String code;
    final String nativeName;

    Language({
        required this.name,
        required this.code,
        required this.nativeName,
    });

    factory Language.fromMap(Map<String, dynamic> map) {
        return Language(
            name: map['name'],
            code: map['code'],
            nativeName: map['nativeName'],
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "name": name,
            "code": code,
            "nativeName": nativeName,
        };
    }
}
