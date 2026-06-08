part of '../../models.dart';

/// OAuth2 Approve
class Oauth2Approve implements Model {
    /// URL the end user should be redirected to after the grant is approved, carrying the authorization `code` and/or `id_token` along with the original `state`.
    final String redirectUrl;

    Oauth2Approve({
        required this.redirectUrl,
    });

    factory Oauth2Approve.fromMap(Map<String, dynamic> map) {
        return Oauth2Approve(
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
