part of appwrite.models;

/// Continents List
class ContinentList {
    /// Total sum of items in the list.
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
            continents: List<Continent>.from(map['continents'].map((p) => Continent.fromMap(p))),
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "sum": sum,
            "continents": continents.map((p) => p.toMap()),
        };
    }
}
