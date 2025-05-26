part of '../../models.dart';

/// Currencies List
class CurrencyList implements Model {
    /// Total number of currencies documents that matched your query.
    final int total;

    /// List of currencies.
    final List<Currency> currencies;

    CurrencyList({
        required this.total,
        required this.currencies,
    });

    factory CurrencyList.fromMap(Map<String, dynamic> map) {
        return CurrencyList(
            total: map['total'],
            currencies: List<Currency>.from(map['currencies'].map((p) => Currency.fromMap(p))),
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "total": total,
            "currencies": currencies.map((p) => p.toMap()).toList(),
        };
    }
}
