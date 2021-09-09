part of appwrite.models;

class Permissions {
    late final List read;
    late final List write;

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
