part of appwrite.models;

/// Permissions
class Permissions {
    /// Read permissions.
    final List read;
    /// Write permissions.
    final List write;

    Permissions({
        required this.read,
        required this.write,
    });

    factory Permissions.fromMap(Map<String, dynamic> map) {
        return Permissions(
            read: map['read'],
            write: map['write'],
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "read": read,
            "write": write,
        };
    }
}
