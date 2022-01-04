part of appwrite.models;

/// Tag
class Tag implements Model {
    /// Tag ID.
    final String $id;
    /// Function ID.
    final String functionId;
    /// The tag creation date in Unix timestamp.
    final int dateCreated;
    /// The entrypoint command in use to execute the tag code.
    final String command;
    /// The code size in bytes.
    final String size;

    Tag({
        required this.$id,
        required this.functionId,
        required this.dateCreated,
        required this.command,
        required this.size,
    });

    factory Tag.fromMap(Map<String, dynamic> map) {
        return Tag(
            $id: map['\$id'].toString(),
            functionId: map['functionId'].toString(),
            dateCreated: map['dateCreated'],
            command: map['command'].toString(),
            size: map['size'].toString(),
        );
    }

    @override
    Map<String, dynamic> toMap() {
        return {
            "\$id": $id,
            "functionId": functionId,
            "dateCreated": dateCreated,
            "command": command,
            "size": size,
        };
    }
}
