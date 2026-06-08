part of '../../models.dart';

/// AppSecretPlaintext
class AppSecretPlaintext implements Model {
  /// Secret ID.
  final String $id;

  /// Secret creation time in ISO 8601 format.
  final String $createdAt;

  /// Secret update time in ISO 8601 format.
  final String $updatedAt;

  /// Application ID this secret belongs to.
  final String appId;

  /// Application client secret. Returned in full only when the secret is created; subsequent reads return a masked value.
  final String secret;

  /// Last few characters of the client secret, used to help identify it.
  final String hint;

  /// ID of the user who created the secret.
  final String createdById;

  /// Name of the user who created the secret.
  final String createdByName;

  /// Time the secret was last used for authentication in ISO 8601 format. Null if never used.
  final String? lastAccessedAt;

  AppSecretPlaintext({
    required this.$id,
    required this.$createdAt,
    required this.$updatedAt,
    required this.appId,
    required this.secret,
    required this.hint,
    required this.createdById,
    required this.createdByName,
    this.lastAccessedAt,
  });

  factory AppSecretPlaintext.fromMap(Map<String, dynamic> map) {
    return AppSecretPlaintext(
      $id: map['\$id'].toString(),
      $createdAt: map['\$createdAt'].toString(),
      $updatedAt: map['\$updatedAt'].toString(),
      appId: map['appId'].toString(),
      secret: map['secret'].toString(),
      hint: map['hint'].toString(),
      createdById: map['createdById'].toString(),
      createdByName: map['createdByName'].toString(),
      lastAccessedAt: map['lastAccessedAt']?.toString(),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "\$id": $id,
      "\$createdAt": $createdAt,
      "\$updatedAt": $updatedAt,
      "appId": appId,
      "secret": secret,
      "hint": hint,
      "createdById": createdById,
      "createdByName": createdByName,
      "lastAccessedAt": lastAccessedAt,
    };
  }
}
