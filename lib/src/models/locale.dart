part of '../../models.dart';

/// Locale
class Locale implements Model {
    /// User IP address.
    final String ip;

    /// Country code in [ISO 3166-1](http://en.wikipedia.org/wiki/ISO_3166-1) two-character format
    final String countryCode;

    /// Country name. This field support localization.
    final String country;

    /// Continent code. A two character continent code &quot;AF&quot; for Africa, &quot;AN&quot; for Antarctica, &quot;AS&quot; for Asia, &quot;EU&quot; for Europe, &quot;NA&quot; for North America, &quot;OC&quot; for Oceania, and &quot;SA&quot; for South America.
    final String continentCode;

    /// Continent name. This field support localization.
    final String continent;

    /// True if country is part of the European Union.
    final bool eu;

    /// Currency code in [ISO 4217-1](http://en.wikipedia.org/wiki/ISO_4217) three-character format
    final String currency;

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
            ip: map['ip'].toString(),
            countryCode: map['countryCode'].toString(),
            country: map['country'].toString(),
            continentCode: map['continentCode'].toString(),
            continent: map['continent'].toString(),
            eu: map['eu'],
            currency: map['currency'].toString(),
        );
    }

    @override
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
