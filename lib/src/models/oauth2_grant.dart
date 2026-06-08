part of '../../models.dart';

/// OAuth2 Grant
class Oauth2Grant implements Model {
    /// Grant ID.
    final String $id;

    /// Grant creation time in ISO 8601 format.
    final String $createdAt;

    /// Grant update date in ISO 8601 format.
    final String $updatedAt;

    /// ID of the user the grant belongs to.
    final String userId;

    /// ID of the OAuth2 client (app) the grant was requested for.
    final String appId;

    /// Requested OAuth2 scopes the user is being asked to consent to.
    final List<String> scopes;

    /// Requested authorization_details the user is being asked to consent to, as a JSON string. Each entry has a `type` plus project-defined fields.
    final String authorizationDetails;

    /// OIDC prompt directive the consent screen should honor. Space-separated list of: login, consent, select_account.
    final String prompt;

    /// Redirect URI the user will be sent to after the flow completes.
    final String redirectUri;

    /// Unix timestamp of when the user last authenticated.
    final int authTime;

    /// Grant expiration time in ISO 8601 format.
    final String expire;

    Oauth2Grant({
        required this.$id,
        required this.$createdAt,
        required this.$updatedAt,
        required this.userId,
        required this.appId,
        required this.scopes,
        required this.authorizationDetails,
        required this.prompt,
        required this.redirectUri,
        required this.authTime,
        required this.expire,
    });

    factory Oauth2Grant.fromMap(Map<String, dynamic> map) {
        return Oauth2Grant(
            $id: map['\$id'].toString(),
            $createdAt: map['\$createdAt'].toString(),
            $updatedAt: map['\$updatedAt'].toString(),
            userId: map['userId'].toString(),
            appId: map['appId'].toString(),
            scopes: List.from(map['scopes'] ?? []),
            authorizationDetails: map['authorizationDetails'].toString(),
            prompt: map['prompt'].toString(),
            redirectUri: map['redirectUri'].toString(),
            authTime: map['authTime'],
            expire: map['expire'].toString(),
        );
    }

    @override
    Map<String, dynamic> toMap() {
        return {
            "\$id": $id,
            "\$createdAt": $createdAt,
            "\$updatedAt": $updatedAt,
            "userId": userId,
            "appId": appId,
            "scopes": scopes,
            "authorizationDetails": authorizationDetails,
            "prompt": prompt,
            "redirectUri": redirectUri,
            "authTime": authTime,
            "expire": expire,
        };
    }
}
