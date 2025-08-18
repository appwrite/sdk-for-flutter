part of '../../models.dart';

/// Document
class Document implements Model {
    /// Document ID.
    final String $id;

    /// Document automatically incrementing ID.
    final int $sequence;

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
        required this.$sequence,
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
            $sequence: map['\$sequence'],
            $collectionId: map['\$collectionId'].toString(),
            $databaseId: map['\$databaseId'].toString(),
            $createdAt: map['\$createdAt'].toString(),
            $updatedAt: map['\$updatedAt'].toString(),
            $permissions: List.from(map['\$permissions'] ?? []),
            data: map,
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "\$id": $id,
            "\$sequence": $sequence,
            "\$collectionId": $collectionId,
            "\$databaseId": $databaseId,
            "\$createdAt": $createdAt,
            "\$updatedAt": $updatedAt,
            "\$permissions": $permissions,
            "data": data,
        };
    }

    T convertTo<T>(T Function(Map<String, dynamic>) fromJson) => fromJson(data);
}
