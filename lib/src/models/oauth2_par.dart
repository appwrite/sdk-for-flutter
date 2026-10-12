part of '../../models.dart';

/// OAuth2 PAR
class Oauth2PAR implements Model {
  /// Authorization request handle to pass to the authorize endpoint.
  final String request_uri;

  /// Lifetime of the authorization request handle in seconds.
  final int expires_in;

  Oauth2PAR({
    required this.request_uri,
    required this.expires_in,
  });
  factory Oauth2PAR.fromMap(
    Map<String, dynamic> map,
  ) {
    return Oauth2PAR(
      request_uri: map['request_uri'].toString(),
      expires_in: map['expires_in'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "request_uri": request_uri,
      "expires_in": expires_in,
    };
  }
}
