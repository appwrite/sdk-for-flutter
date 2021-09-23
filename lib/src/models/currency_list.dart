part of appwrite.models;

class CurrencyList {
    final int sum;
    final List<Currency> currencies;

    CurrencyList({
        required this.sum,
        required this.currencies,
    });

    factory CurrencyList.fromMap(Map<String, dynamic> map) {
        return CurrencyList(
            sum: map['sum'],
            currencies: List<Currency>.from(map['currencies'].map((p) => Currency.fromMap(p))),
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "sum": sum,
            "currencies": currencies.map((p) => p.toMap()),
        };
    }
}
