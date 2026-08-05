part of '../../models.dart';

/// OAuth2 Consent
class Oauth2Consent implements Model {
  /// Consent ID.
  final String $id;

  /// Consent creation time in ISO 8601 format.
  final String $createdAt;

  /// Consent update date in ISO 8601 format.
  final String $updatedAt;

  /// ID of the user the consent belongs to.
  final String userId;

  /// ID of the registered app the consent was given to. Empty for URL-form (CIMD) clients.
  final String appId;

  /// Client ID metadata document URL of the client the consent was given to. Empty for registered apps.
  final String cimdUrl;

  /// OAuth2 scopes the user consented to.
  final List<String> scopes;

  /// RFC 8707 resource indicators the user consented to.
  final List<String> resources;

  /// Authorization details the user consented to, as a JSON string. Each entry has a `type` plus project-defined fields.
  final String authorizationDetails;

  /// Consent expiration time in ISO 8601 format. Empty when the consent has no token-bound expiry yet.
  final String expire;

  Oauth2Consent({
    required this.$id,
    required this.$createdAt,
    required this.$updatedAt,
    required this.userId,
    required this.appId,
    required this.cimdUrl,
    required this.scopes,
    required this.resources,
    required this.authorizationDetails,
    required this.expire,
  });

  factory Oauth2Consent.fromMap(Map<String, dynamic> map) {
    return Oauth2Consent(
      $id: map['\$id'].toString(),
      $createdAt: map['\$createdAt'].toString(),
      $updatedAt: map['\$updatedAt'].toString(),
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
