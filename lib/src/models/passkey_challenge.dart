part of '../../models.dart';

/// Passkey Challenge
class PasskeyChallenge implements Model {
  /// Challenge ID. When signing in, pass it back with the credential to receive a token.
  final String $id;

  /// Challenge creation date in ISO 8601 format.
  final String $createdAt;

  /// ID of the passkey being registered. Empty for sign-in challenges.
  final String passkeyId;

  /// Challenge expiration date in ISO 8601 format.
  final String expire;

  /// WebAuthn options in JSON form. Pass them to `PublicKeyCredential.parseCreationOptionsFromJSON()` when registering, or `PublicKeyCredential.parseRequestOptionsFromJSON()` when signing in.
  final Map<String, dynamic> publicKey;

  PasskeyChallenge({
    required this.$id,
    required this.$createdAt,
    required this.passkeyId,
    required this.expire,
    required this.publicKey,
  });
  factory PasskeyChallenge.fromMap(
    Map<String, dynamic> map,
  ) {
    map = {
      '\$id': "",
      '\$createdAt': "",
      'passkeyId': "",
      'expire': "",
      'publicKey': <String, dynamic>{},
      ...map,
    };

    return PasskeyChallenge(
      $id: map['\$id'].toString(),
      $createdAt: map['\$createdAt'].toString(),
      passkeyId: map['passkeyId'].toString(),
      expire: map['expire'].toString(),
      publicKey: map['publicKey'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "\$id": $id,
      "\$createdAt": $createdAt,
      "passkeyId": passkeyId,
      "expire": expire,
      "publicKey": publicKey,
    };
  }
}
