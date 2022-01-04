part of appwrite.models;

/// Index
class Index implements Model {
    /// Index Key.
    final String key;
    /// Index type.
    final String type;
    /// Index status. Possible values: `available`, `processing`, `deleting`, `stuck`, or `failed`
    final String status;
    /// Index attributes.
    final List attributes;
    /// Index orders.
    final List orders;

    Index({
        required this.key,
        required this.type,
        required this.status,
        required this.attributes,
        required this.orders,
    });

    factory Index.fromMap(Map<String, dynamic> map) {
        return Index(
            key: map['key'].toString(),
            type: map['type'].toString(),
            status: map['status'].toString(),
            attributes: map['attributes'],
            orders: map['orders'],
        );
    }

    @override
    Map<String, dynamic> toMap() {
        return {
            "key": key,
            "type": type,
            "status": status,
            "attributes": attributes,
            "orders": orders,
        };
    }
}
