part of appwrite.models;

class Currency {
    late final String symbol;
    late final String name;
    late final String symbolNative;
    late final int decimalDigits;
    late final double rounding;
    late final String code;
    late final String namePlural;

    Currency({
        required this.symbol,
        required this.name,
        required this.symbolNative,
        required this.decimalDigits,
        required this.rounding,
        required this.code,
        required this.namePlural,
    });

    factory Currency.fromMap(Map<String, dynamic> map) {
        return Currency(
            symbol: map['symbol'],
            name: map['name'],
            symbolNative: map['symbolNative'],
            decimalDigits: map['decimalDigits'],
            rounding: map['rounding'].toDouble(),
            code: map['code'],
            namePlural: map['namePlural'],
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "symbol": symbol,
            "name": name,
            "symbolNative": symbolNative,
            "decimalDigits": decimalDigits,
            "rounding": rounding,
            "code": code,
            "namePlural": namePlural,
        };
    }

}
