part of '../../models.dart';

/// Continents List
class ContinentList implements Model {
  /// Total number of continents that matched your query.
  final int total;

  /// List of continents.
  final List<Continent> continents;

  ContinentList({required this.total, required this.continents});

  factory ContinentList.fromMap(Map<String, dynamic> map) {
    return ContinentList(
      total: map['total'],
      continents: List<Continent>.from(
        map['continents'].map((p) => Continent.fromMap(p)),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "total": total,
      "continents": continents.map((p) => p.toMap()).toList(),
    };
  }
}
