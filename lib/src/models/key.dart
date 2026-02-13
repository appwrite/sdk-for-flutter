part of '../../models.dart';

/// Key
class Key implements Model {
  /// Key ID.
  final String $id;

  /// Key creation date in ISO 8601 format.
  final String $createdAt;

  /// Key update date in ISO 8601 format.
  final String $updatedAt;

  /// Key name.
  final String name;

  /// Key expiration date in ISO 8601 format.
  final String expire;

  /// Allowed permission scopes.
  final List<String> scopes;

  /// Secret key.
  final String secret;

  /// Most recent access date in ISO 8601 format. This attribute is only updated again after 24 hours.
  final String accessedAt;

  /// List of SDK user agents that used this key.
  final List<String> sdks;

  Key({
    required this.$id,
    required this.$createdAt,
    required this.$updatedAt,
    required this.name,
    required this.expire,
    required this.scopes,
    required this.secret,
    required this.accessedAt,
    required this.sdks,
  });

  factory Key.fromMap(Map<String, dynamic> map) {
    return Key(
      $id: map['\$id'].toString(),
      $createdAt: map['\$createdAt'].toString(),
      $updatedAt: map['\$updatedAt'].toString(),
      name: map['name'].toString(),
      expire: map['expire'].toString(),
      scopes: List.from(map['scopes'] ?? []),
      secret: map['secret'].toString(),
      accessedAt: map['accessedAt'].toString(),
      sdks: List.from(map['sdks'] ?? []),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "\$id": $id,
      "\$createdAt": $createdAt,
      "\$updatedAt": $updatedAt,
      "name": name,
      "expire": expire,
      "scopes": scopes,
      "secret": secret,
      "accessedAt": accessedAt,
      "sdks": sdks,
    };
  }
}
