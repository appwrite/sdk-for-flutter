part of '../../models.dart';

/// Passkey
class Passkey implements Model {
  /// Passkey ID.
  final String $id;

  /// Passkey creation date in ISO 8601 format.
  final String $createdAt;

  /// Passkey update date in ISO 8601 format.
  final String $updatedAt;

  /// Passkey name.
  final String name;

  /// Most recent sign-in with this passkey in ISO 8601 format. Empty until the passkey is used to sign in.
  final String accessedAt;

  Passkey({
    required this.$id,
    required this.$createdAt,
    required this.$updatedAt,
    required this.name,
    required this.accessedAt,
  });
  factory Passkey.fromMap(
    Map<String, dynamic> map,
  ) {
    return Passkey(
      $id: map['\$id'].toString(),
      $createdAt: map['\$createdAt'].toString(),
      $updatedAt: map['\$updatedAt'].toString(),
      name: map['name'].toString(),
      accessedAt: map['accessedAt'].toString(),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "\$id": $id,
      "\$createdAt": $createdAt,
      "\$updatedAt": $updatedAt,
      "name": name,
      "accessedAt": accessedAt,
    };
  }
}
