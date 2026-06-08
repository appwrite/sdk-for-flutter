part of '../../models.dart';

/// OAuth2 Authorize
class Oauth2Authorize implements Model {
  /// OAuth2 grant ID. Set when the user must give explicit consent; pass it to the approve or reject endpoint. Empty when a redirect URL is returned instead.
  final String grantId;

  /// URL the end user should be redirected to when the flow can complete without consent. Empty when consent is still required.
  final String redirectUrl;

  Oauth2Authorize({
    required this.grantId,
    required this.redirectUrl,
  });

  factory Oauth2Authorize.fromMap(Map<String, dynamic> map) {
    return Oauth2Authorize(
      grantId: map['grantId'].toString(),
      redirectUrl: map['redirectUrl'].toString(),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "grantId": grantId,
      "redirectUrl": redirectUrl,
    };
  }
}
