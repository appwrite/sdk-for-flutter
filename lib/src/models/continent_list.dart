part of appwrite.models;

/// Continents List
class ContinentList implements Model {
  /// Total number of items available on the server.
  final int sum;

  /// List of continents.
  final List<Continent> continents;

  ContinentList({
    required this.sum,
    required this.continents,
  });

  factory ContinentList.fromMap(Map<String, dynamic> map) {
    return ContinentList(
      sum: map['sum'],
      continents: List<Continent>.from(
          map['continents'].map((p) => Continent.fromMap(p))),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "sum": sum,
      "continents": continents.map((p) => p.toMap()),
    };
  }
}
