part of '../../models.dart';

/// OAuth2 Reject
class Oauth2Reject implements Model {
  /// URL the end user should be redirected to after the grant is rejected, carrying an `access_denied` error.
  final String redirectUrl;

  Oauth2Reject({
    required this.redirectUrl,
  });

  factory Oauth2Reject.fromMap(Map<String, dynamic> map) {
    return Oauth2Reject(
      redirectUrl: map['redirectUrl'].toString(),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "redirectUrl": redirectUrl,
    };
  }
}
