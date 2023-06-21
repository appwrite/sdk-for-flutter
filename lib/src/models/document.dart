part of appwrite.models;

/// Document
class Document implements Model {
    /// Document ID.
    final String $id;
    /// Collection ID.
    final String $collection;
    /// Document read permissions.
    final List $read;
    /// Document write permissions.
    final List $write;
    final Map<String, dynamic> data;

    Document({
        required this.$id,
        required this.$collection,
        required this.$read,
        required this.$write,
        required this.data,
    });

    factory Document.fromMap(Map<String, dynamic> map) {
        return Document(
            $id: map['\$id'].toString(),
            $collection: map['\$collection'].toString(),
            $read: map['\$read'],
            $write: map['\$write'],
            data: map,
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "\$id": $id,
            "\$collection": $collection,
            "\$read": $read,
            "\$write": $write,
            "data": data,
        };
    }

    T convertTo<T>(T Function(Map) fromJson) => fromJson(data);
}
