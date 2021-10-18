part of appwrite.models;

/// Countries List
class CountryList {
    /// Total number of items available on the server.
    final int sum;
    /// List of countries.
    final List<Country> countries;

    CountryList({
        required this.sum,
        required this.countries,
    });

    factory CountryList.fromMap(Map<String, dynamic> map) {
        return CountryList(
            sum: map['sum'],
            countries: List<Country>.from(map['countries'].map((p) => Country.fromMap(p))),
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "sum": sum,
            "countries": countries.map((p) => p.toMap()),
        };
    }
}
