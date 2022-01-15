part of appwrite.models;

/// Currencies List
class CurrencyList implements Model {
  /// Total number of items available on the server.
  final int sum;

  /// List of currencies.
  final List<Currency> currencies;

  CurrencyList({
    required this.sum,
    required this.currencies,
  });

  factory CurrencyList.fromMap(Map<String, dynamic> map) {
    return CurrencyList(
      sum: map['sum'],
      currencies: List<Currency>.from(
          map['currencies'].map((p) => Currency.fromMap(p))),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "sum": sum,
      "currencies": currencies.map((p) => p.toMap()),
    };
  }
}
