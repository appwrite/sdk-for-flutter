part of '../../models.dart';

/// Countries List
class CountryList implements Model {
    /// Total number of countries that matched your query.
    final int total;

    /// List of countries.
    final List<Country> countries;

    CountryList({
        required this.total,
        required this.countries,
    });

    factory CountryList.fromMap(Map<String, dynamic> map) {
        return CountryList(
            total: map['total'],
            countries: List<Country>.from(map['countries'].map((p) => Country.fromMap(p))),
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "total": total,
            "countries": countries.map((p) => p.toMap()).toList(),
        };
    }
}
