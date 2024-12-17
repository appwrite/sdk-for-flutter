part of '../../models.dart';

/// Document
class Document implements Model {
  /// Document ID.
  final String $id;

  /// Collection ID.
  final String $collectionId;

  /// Database ID.
  final String $databaseId;

  /// Document creation date in ISO 8601 format.
  final String $createdAt;

  /// Document update date in ISO 8601 format.
  final String $updatedAt;

  /// Document permissions. [Learn more about permissions](https://appwrite.io/docs/permissions).
  final List<String> $permissions;
  final Map<String, dynamic> data;

  Document({
    required this.$id,
    required this.$collectionId,
    required this.$databaseId,
    required this.$createdAt,
    required this.$updatedAt,
    required this.$permissions,
    required this.data,
  });

  factory Document.fromMap(Map<String, dynamic> map) {
    return Document(
      $id: map['\$id'].toString(),
      $collectionId: map['\$collectionId'].toString(),
      $databaseId: map['\$databaseId'].toString(),
      $createdAt: map['\$createdAt'].toString(),
      $updatedAt: map['\$updatedAt'].toString(),
      $permissions: map['\$permissions'] ?? [],
      data: map,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "\$id": $id,
      "\$collectionId": $collectionId,
      "\$databaseId": $databaseId,
      "\$createdAt": $createdAt,
      "\$updatedAt": $updatedAt,
      "\$permissions": $permissions,
      "data": data,
    };
  }

  T convertTo<T>(T Function(Map) fromJson) => fromJson(data);
}
