part of appwrite.models;

/// Collection
class Collection implements Model {
    /// Collection ID.
    final String $id;
    /// Collection read permissions.
    final List $read;
    /// Collection write permissions.
    final List $write;
    /// Collection name.
    final String name;
    /// Collection enabled.
    final bool enabled;
    /// Collection permission model. Possible values: `document` or `collection`
    final String permission;
    /// Collection attributes.
    final List attributes;
    /// Collection indexes.
    final List<Index> indexes;

    Collection({
        required this.$id,
        required this.$read,
        required this.$write,
        required this.name,
        required this.enabled,
        required this.permission,
        required this.attributes,
        required this.indexes,
    });

    factory Collection.fromMap(Map<String, dynamic> map) {
        return Collection(
            $id: map['\$id'].toString(),
            $read: map['\$read'],
            $write: map['\$write'],
            name: map['name'].toString(),
            enabled: map['enabled'],
            permission: map['permission'].toString(),
            attributes: map['attributes'],
            indexes: List<Index>.from(map['indexes'].map((p) => Index.fromMap(p))),
        );
    }

    @override
    Map<String, dynamic> toMap() {
        return {
            "\$id": $id,
            "\$read": $read,
            "\$write": $write,
            "name": name,
            "enabled": enabled,
            "permission": permission,
            "attributes": attributes,
            "indexes": indexes.map((p) => p.toMap()),
        };
    }
}
