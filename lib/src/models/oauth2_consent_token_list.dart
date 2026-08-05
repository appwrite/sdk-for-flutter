part of '../../models.dart';

/// OAuth2 consent tokens list
class Oauth2ConsentTokenList implements Model {
    /// Total number of tokens that matched your query.
    final int total;

    /// List of tokens.
    final List<Oauth2ConsentToken> tokens;

    Oauth2ConsentTokenList({
        required this.total,
        required this.tokens,
    });

    factory Oauth2ConsentTokenList.fromMap(Map<String, dynamic> map) {
        return Oauth2ConsentTokenList(
            total: map['total'],
            tokens: List<Oauth2ConsentToken>.from(map['tokens'].map((p) => Oauth2ConsentToken.fromMap(p))),
        );
    }

    @override
    Map<String, dynamic> toMap() {
        return {
            "total": total,
            "tokens": tokens.map((p) => p.toMap()).toList(),
        };
    }
}
