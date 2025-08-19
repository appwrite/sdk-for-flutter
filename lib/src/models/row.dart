part of '../../models.dart';

/// Row
class Row implements Model {
    /// Row ID.
    final String $id;

    /// Row automatically incrementing ID.
    final int $sequence;

    /// Table ID.
    final String $tableId;

    /// Database ID.
    final String $databaseId;

    /// Row creation date in ISO 8601 format.
    final String $createdAt;

    /// Row update date in ISO 8601 format.
    final String $updatedAt;

    /// Row permissions. [Learn more about permissions](https://appwrite.io/docs/permissions).
    final List<String> $permissions;

    final Map<String, dynamic> data;

    Row({
        required this.$id,
        required this.$sequence,
        required this.$tableId,
        required this.$databaseId,
        required this.$createdAt,
        required this.$updatedAt,
        required this.$permissions,
        required this.data,
    });

    factory Row.fromMap(Map<String, dynamic> map) {
        return Row(
            $id: map['\$id'].toString(),
            $sequence: map['\$sequence'],
            $tableId: map['\$tableId'].toString(),
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
            "\$tableId": $tableId,
            "\$databaseId": $databaseId,
            "\$createdAt": $createdAt,
            "\$updatedAt": $updatedAt,
            "\$permissions": $permissions,
            "data": data,
        };
    }

    T convertTo<T>(T Function(Map<String, dynamic>) fromJson) => fromJson(data);
}
