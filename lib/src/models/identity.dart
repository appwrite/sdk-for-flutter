part of '../../models.dart';

/// Identity
class Identity implements Model {
  /// Identity ID.
  final String $id;

  /// Identity creation date in ISO 8601 format.
  final String $createdAt;

  /// Identity update date in ISO 8601 format.
  final String $updatedAt;

  /// User ID.
  final String userId;

  /// Identity Provider.
  final String provider;

  /// ID of the User in the Identity Provider.
  final String providerUid;

  /// Email of the User in the Identity Provider.
  final String providerEmail;

  /// Identity Provider Access Token.
  final String providerAccessToken;

  /// The date of when the access token expires in ISO 8601 format.
  final String providerAccessTokenExpiry;

  /// Identity Provider Refresh Token.
  final String providerRefreshToken;

  /// Identity Provider ID token (JWT) from the most recent native sign-in. Empty for identities created through the browser OAuth2 flow.
  final String providerIdToken;

  Identity({
    required this.$id,
    required this.$createdAt,
    required this.$updatedAt,
    required this.userId,
    required this.provider,
    required this.providerUid,
    required this.providerEmail,
    required this.providerAccessToken,
    required this.providerAccessTokenExpiry,
    required this.providerRefreshToken,
    required this.providerIdToken,
  });
  factory Identity.fromMap(
    Map<String, dynamic> map,
  ) {
    return Identity(
      $id: map['\$id'].toString(),
      $createdAt: map['\$createdAt'].toString(),
      $updatedAt: map['\$updatedAt'].toString(),
      userId: map['userId'].toString(),
      provider: map['provider'].toString(),
      providerUid: map['providerUid'].toString(),
      providerEmail: map['providerEmail'].toString(),
      providerAccessToken: map['providerAccessToken'].toString(),
      providerAccessTokenExpiry: map['providerAccessTokenExpiry'].toString(),
      providerRefreshToken: map['providerRefreshToken'].toString(),
      providerIdToken: map['providerIdToken'].toString(),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "\$id": $id,
      "\$createdAt": $createdAt,
      "\$updatedAt": $updatedAt,
      "userId": userId,
      "provider": provider,
      "providerUid": providerUid,
      "providerEmail": providerEmail,
      "providerAccessToken": providerAccessToken,
      "providerAccessTokenExpiry": providerAccessTokenExpiry,
      "providerRefreshToken": providerRefreshToken,
      "providerIdToken": providerIdToken,
    };
  }
}
