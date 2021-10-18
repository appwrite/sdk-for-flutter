part of appwrite.models;

/// Languages List
class LanguageList {
    /// Total number of items available on the server.
    final int sum;
    /// List of languages.
    final List<Language> languages;

    LanguageList({
        required this.sum,
        required this.languages,
    });

    factory LanguageList.fromMap(Map<String, dynamic> map) {
        return LanguageList(
            sum: map['sum'],
            languages: List<Language>.from(map['languages'].map((p) => Language.fromMap(p))),
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "sum": sum,
            "languages": languages.map((p) => p.toMap()),
        };
    }
}
