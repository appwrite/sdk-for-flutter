part of '../../models.dart';

/// Token Secret
class TokenSecret implements Model {
  /// Token ID.
  final String $id;

  /// Token creation date in ISO 8601 format.
  final String $createdAt;

  /// User ID.
  final String userId;

  /// Token secret key. Exchange it for a session with the create session endpoint.
  final String secret;

  /// Token expiration date in ISO 8601 format.
  final String expire;

  /// Security phrase of a token. Empty if security phrase was not requested when creating a token. It includes randomly generated phrase which is also sent in the external resource such as email.
  final String phrase;

  TokenSecret({
    required this.$id,
    required this.$createdAt,
    required this.userId,
    required this.secret,
    required this.expire,
    required this.phrase,
  });
  factory TokenSecret.fromMap(
    Map<String, dynamic> map,
  ) {
    map = {
      '\$id': "",
      '\$createdAt': "",
      'userId': "",
      'secret': "",
      'expire': "",
      'phrase': "",
      ...map,
    };

    return TokenSecret(
      $id: map['\$id'].toString(),
      $createdAt: map['\$createdAt'].toString(),
      userId: map['userId'].toString(),
      secret: map['secret'].toString(),
      expire: map['expire'].toString(),
      phrase: map['phrase'].toString(),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "\$id": $id,
      "\$createdAt": $createdAt,
      "userId": userId,
      "secret": secret,
      "expire": expire,
      "phrase": phrase,
    };
  }
}
