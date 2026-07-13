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

    /// City
    final String? city;

    /// Name of timezone
    final String? timeZone;

    /// Postal code
    final String? postalCode;

    /// Latitude
    final double? latitude;

    /// Longitude
    final double? longitude;

    /// Autonomous System Number (ASN) of the IP
    final String? autonomousSystemNumber;

    /// Organization that owns the ASN
    final String? autonomousSystemOrganization;

    /// Internet service provider of the IP
    final String? isp;

    /// Connection type of the IP (e.g. cable, cellular, corporate)
    final String? connectionType;

    /// User type classification of the IP (e.g. residential, business, hosting)
    final String? connectionUsageType;

    /// Registered organization of the IP
    final String? connectionOrganization;

    Locale({
        required this.ip,
        required this.countryCode,
        required this.country,
        required this.continentCode,
        required this.continent,
        required this.eu,
        required this.currency,
        this.city,
        this.timeZone,
        this.postalCode,
        this.latitude,
        this.longitude,
        this.autonomousSystemNumber,
        this.autonomousSystemOrganization,
        this.isp,
        this.connectionType,
        this.connectionUsageType,
        this.connectionOrganization,
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
            city: map['city']?.toString(),
            timeZone: map['timeZone']?.toString(),
            postalCode: map['postalCode']?.toString(),
            latitude: map['latitude']?.toDouble(),
            longitude: map['longitude']?.toDouble(),
            autonomousSystemNumber: map['autonomousSystemNumber']?.toString(),
            autonomousSystemOrganization: map['autonomousSystemOrganization']?.toString(),
            isp: map['isp']?.toString(),
            connectionType: map['connectionType']?.toString(),
            connectionUsageType: map['connectionUsageType']?.toString(),
            connectionOrganization: map['connectionOrganization']?.toString(),
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
            "city": city,
            "timeZone": timeZone,
            "postalCode": postalCode,
            "latitude": latitude,
            "longitude": longitude,
            "autonomousSystemNumber": autonomousSystemNumber,
            "autonomousSystemOrganization": autonomousSystemOrganization,
            "isp": isp,
            "connectionType": connectionType,
            "connectionUsageType": connectionUsageType,
            "connectionOrganization": connectionOrganization,
        };
    }
}
