part of '../../models.dart';

/// MFA Challenge
class MfaChallenge implements Model {
    /// Token ID.
    final String $id;
    /// Token creation date in ISO 8601 format.
    final String $createdAt;
    /// User ID.
    final String userId;
    /// Token expiration date in ISO 8601 format.
    final String expire;

    MfaChallenge({
        required this.$id,
        required this.$createdAt,
        required this.userId,
        required this.expire,
    });

    factory MfaChallenge.fromMap(Map<String, dynamic> map) {
        return MfaChallenge(
            $id: map['\$id'].toString(),
            $createdAt: map['\$createdAt'].toString(),
            userId: map['userId'].toString(),
            expire: map['expire'].toString(),
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "\$id": $id,
            "\$createdAt": $createdAt,
            "userId": userId,
            "expire": expire,
        };
    }
}
