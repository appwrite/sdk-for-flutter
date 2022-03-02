part of appwrite.models;

/// File
class File implements Model {
    /// File ID.
    final String $id;
    /// Bucket ID.
    final String bucketId;
    /// File read permissions.
    final List $read;
    /// File write permissions.
    final List $write;
    /// File name.
    final String name;
    /// File creation date in Unix timestamp.
    final int dateCreated;
    /// File MD5 signature.
    final String signature;
    /// File mime type.
    final String mimeType;
    /// File original size in bytes.
    final int sizeOriginal;
    /// Total number of chunks available
    final int chunksTotal;
    /// Total number of chunks uploaded
    final int chunksUploaded;

    File({
        required this.$id,
        required this.bucketId,
        required this.$read,
        required this.$write,
        required this.name,
        required this.dateCreated,
        required this.signature,
        required this.mimeType,
        required this.sizeOriginal,
        required this.chunksTotal,
        required this.chunksUploaded,
    });

    factory File.fromMap(Map<String, dynamic> map) {
        return File(
            $id: map['\$id'].toString(),
            bucketId: map['bucketId'].toString(),
            $read: map['\$read'],
            $write: map['\$write'],
            name: map['name'].toString(),
            dateCreated: map['dateCreated'],
            signature: map['signature'].toString(),
            mimeType: map['mimeType'].toString(),
            sizeOriginal: map['sizeOriginal'],
            chunksTotal: map['chunksTotal'],
            chunksUploaded: map['chunksUploaded'],
        );
    }

    @override
    Map<String, dynamic> toMap() {
        return {
            "\$id": $id,
            "bucketId": bucketId,
            "\$read": $read,
            "\$write": $write,
            "name": name,
            "dateCreated": dateCreated,
            "signature": signature,
            "mimeType": mimeType,
            "sizeOriginal": sizeOriginal,
            "chunksTotal": chunksTotal,
            "chunksUploaded": chunksUploaded,
        };
    }
}
