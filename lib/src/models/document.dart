part of appwrite.models;

/// Document
class Document implements Model {
    /// Document ID.
    final String $id;
    /// Collection ID.
    final String $collection;
    /// Document permissions.
    final Permissions $permissions;
    final Map<String, dynamic> data;

    Document({
        required this.$id,
        required this.$collection,
        required this.$permissions,
        required this.data,
    });

    factory Document.fromMap(Map<String, dynamic> map) {
        return Document(
            $id: map['\$id'],
            $collection: map['\$collection'],
            $permissions: Permissions.fromMap(map['\$permissions']),
            data: map,
        );
    }

    @override
    Map<String, dynamic> toMap() {
        return {
            "\$id": $id,
            "\$collection": $collection,
            "\$permissions": $permissions.toMap(),
            "data": data,
        };
    }

    T convertTo<T>(T Function(Map) fromJson) => fromJson(data);
}
