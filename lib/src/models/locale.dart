part of appwrite.models;

class Locale {
    late final String ip;
    late final String countryCode;
    late final String country;
    late final String continentCode;
    late final String continent;
    late final bool eu;
    late final String currency;

    Locale({
        required this.ip,
        required this.countryCode,
        required this.country,
        required this.continentCode,
        required this.continent,
        required this.eu,
        required this.currency,
    });

    factory Locale.fromMap(Map<String, dynamic> map) {
        return Locale(
            ip: map['ip'],
            countryCode: map['countryCode'],
            country: map['country'],
            continentCode: map['continentCode'],
            continent: map['continent'],
            eu: map['eu'],
            currency: map['currency'],
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "ip": ip,
            "countryCode": countryCode,
            "country": country,
            "continentCode": continentCode,
            "continent": continent,
            "eu": eu,
            "currency": currency,
        };
    }

}
