part of appwrite.models;

class ContinentList {
    late final int sum;
    late final List<Continent> continents;

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
