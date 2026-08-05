part of '../../models.dart';

/// OAuth2 consents list
class Oauth2ConsentList implements Model {
    /// Total number of consents that matched your query.
    final int total;

    /// List of consents.
    final List<Oauth2Consent> consents;

    Oauth2ConsentList({
        required this.total,
        required this.consents,
    });

    factory Oauth2ConsentList.fromMap(Map<String, dynamic> map) {
        return Oauth2ConsentList(
            total: map['total'],
            consents: List<Oauth2Consent>.from(map['consents'].map((p) => Oauth2Consent.fromMap(p))),
        );
    }

    @override
    Map<String, dynamic> toMap() {
        return {
            "total": total,
            "consents": consents.map((p) => p.toMap()).toList(),
        };
    }
}
