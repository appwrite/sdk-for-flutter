part of '../../models.dart';

/// OAuth2 Consent Token
class Oauth2ConsentToken implements Model {
  /// Token family ID.
  final String $id;

  /// Token creation time in ISO 8601 format.
  final String $createdAt;

  /// Token update date in ISO 8601 format. Refreshing the token family updates this.
  final String $updatedAt;

  /// ID of the consent the token family was issued under.
  final String consentId;

  /// ID of the user the token family belongs to.
  final String userId;

  /// ID of the registered app the token family was issued to. Empty for URL-form (CIMD) clients.
  final String appId;

  /// Client ID metadata document URL of the client the token family was issued to. Empty for registered apps.
  final String cimdUrl;

  /// OAuth2 scopes granted on the token family.
  final List<String> scopes;

  /// RFC 8707 resource indicators granted on the token family.
  final List<String> resources;

  /// Authorization details granted on the token family, as a JSON string. Each entry has a `type` plus project-defined fields.
  final String authorizationDetails;

  /// Expiration time of the current access token of this family in ISO 8601 format.
  final String expire;

  Oauth2ConsentToken({
    required this.$id,
    required this.$createdAt,
    required this.$updatedAt,
    required this.consentId,
    required this.userId,
    required this.appId,
    required this.cimdUrl,
    required this.scopes,
    required this.resources,
    required this.authorizationDetails,
    required this.expire,
  });

  factory Oauth2ConsentToken.fromMap(Map<String, dynamic> map) {
    return Oauth2ConsentToken(
      $id: map['\$id'].toString(),
      $createdAt: map['\$createdAt'].toString(),
      $updatedAt: map['\$updatedAt'].toString(),
      consentId: map['consentId'].toString(),
      userId: map['userId'].toString(),
      appId: map['appId'].toString(),
      cimdUrl: map['cimdUrl'].toString(),
      scopes: List.from(map['scopes'] ?? []),
      resources: List.from(map['resources'] ?? []),
      authorizationDetails: map['authorizationDetails'].toString(),
      expire: map['expire'].toString(),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "\$id": $id,
      "\$createdAt": $createdAt,
      "\$updatedAt": $updatedAt,
      "consentId": consentId,
      "userId": userId,
      "appId": appId,
      "cimdUrl": cimdUrl,
      "scopes": scopes,
      "resources": resources,
      "authorizationDetails": authorizationDetails,
      "expire": expire,
    };
  }
}
