part of '../../models.dart';

/// OAuth2 Token
class Oauth2Token implements Model {
  /// OAuth2 access token.
  final String access_token;

  /// OAuth2 token type.
  final String token_type;

  /// Access token lifetime in seconds.
  final int expires_in;

  /// OAuth2 refresh token.
  final String refresh_token;

  /// Space-separated scopes granted to the access token.
  final String scope;

  /// Granted RFC 9396 authorization details as a JSON string.
  final String? authorization_details;

  /// OpenID Connect ID token. Returned when the `openid` scope is granted.
  final String? id_token;

  Oauth2Token({
    required this.access_token,
    required this.token_type,
    required this.expires_in,
    required this.refresh_token,
    required this.scope,
    this.authorization_details,
    this.id_token,
  });
  factory Oauth2Token.fromMap(
    Map<String, dynamic> map,
  ) {
    return Oauth2Token(
      access_token: map['access_token'].toString(),
      token_type: map['token_type'].toString(),
      expires_in: map['expires_in'],
      refresh_token: map['refresh_token'].toString(),
      scope: map['scope'].toString(),
      authorization_details: map['authorization_details']?.toString(),
      id_token: map['id_token']?.toString(),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "access_token": access_token,
      "token_type": token_type,
      "expires_in": expires_in,
      "refresh_token": refresh_token,
      "scope": scope,
      "authorization_details": authorization_details,
      "id_token": id_token,
    };
  }
}
