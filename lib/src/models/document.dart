part of appwrite.models;

/// Document
class Document implements Model {
    /// Document ID.
    final String $id;
    /// Collection ID.
    final String $collection;
    /// Document creation date in ISO 8601 format.
    final String $createdAt;
    /// Document update date in ISO 8601 format.
    final String $updatedAt;
    /// Document permissions. [Learn more about permissions](/docs/permissions).
    final List $permissions;
    final Map<String, dynamic> data;

    Document({
        required this.$id,
        required this.$collection,
        required this.$createdAt,
        required this.$updatedAt,
        required this.$permissions,
        required this.data,
    });

    factory Document.fromMap(Map<String, dynamic> map) {
        return Document(
            $id: map['\$id'].toString(),
            $collection: map['\$collection'].toString(),
            $createdAt: map['\$createdAt'].toString(),
            $updatedAt: map['\$updatedAt'].toString(),
            $permissions: map['\$permissions'],
            data: map,
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "\$id": $id,
            "\$collection": $collection,
            "\$createdAt": $createdAt,
            "\$updatedAt": $updatedAt,
            "\$permissions": $permissions,
            "data": data,
        };
    }

    T convertTo<T>(T Function(Map) fromJson) => fromJson(data);
}
