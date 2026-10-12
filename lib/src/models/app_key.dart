part of '../../models.dart';

/// AppKey
class AppKey implements Model {
  /// App key ID.
  final String $id;

  /// App key creation time in ISO 8601 format.
  final String $createdAt;

  /// App key update time in ISO 8601 format.
  final String $updatedAt;

  /// Application ID this app key belongs to.
  final String appId;

  /// App key secret.
  final String secret;

  /// Last few characters of the app key secret, used to help identify it.
  final String hint;

  /// ID of the user who created the app key.
  final String createdById;

  /// Name of the user who created the app key.
  final String createdByName;

  /// Time the app key was last used for authentication in ISO 8601 format. Null if never used.
  final String? lastAccessedAt;

  AppKey({
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
  factory AppKey.fromMap(
    Map<String, dynamic> map,
  ) {
    return AppKey(
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
