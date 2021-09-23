part of appwrite.models;

class File {
    final String $id;
    final Permissions $permissions;
    final String name;
    final int dateCreated;
    final String signature;
    final String mimeType;
    final int sizeOriginal;

    File({
        required this.$id,
        required this.$permissions,
        required this.name,
        required this.dateCreated,
        required this.signature,
        required this.mimeType,
        required this.sizeOriginal,
    });

    factory File.fromMap(Map<String, dynamic> map) {
        return File(
            $id: map['\$id'],
            $permissions: Permissions.fromMap(map['\$permissions']),
            name: map['name'],
            dateCreated: map['dateCreated'],
            signature: map['signature'],
            mimeType: map['mimeType'],
            sizeOriginal: map['sizeOriginal'],
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "\$id": $id,
            "\$permissions": $permissions.toMap(),
            "name": name,
            "dateCreated": dateCreated,
            "signature": signature,
            "mimeType": mimeType,
            "sizeOriginal": sizeOriginal,
        };
    }
}
