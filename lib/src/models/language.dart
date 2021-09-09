part of appwrite.models;

class Language {
    late final String name;
    late final String code;
    late final String nativeName;

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
