part of '../../models.dart';

/// Languages List
class LanguageList implements Model {
  /// Total number of languages that matched your query.
  final int total;

  /// List of languages.
  final List<Language> languages;

  LanguageList({required this.total, required this.languages});

  factory LanguageList.fromMap(Map<String, dynamic> map) {
    return LanguageList(
      total: map['total'],
      languages: List<Language>.from(
        map['languages'].map((p) => Language.fromMap(p)),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "total": total,
      "languages": languages.map((p) => p.toMap()).toList(),
    };
  }
}
