part of '../../models.dart';

/// File
class File implements Model {
  /// File ID.
  final String $id;

  /// Bucket ID.
  final String bucketId;

  /// File creation date in ISO 8601 format.
  final String $createdAt;

  /// File update date in ISO 8601 format.
  final String $updatedAt;

  /// File permissions. [Learn more about permissions](https://appwrite.io/docs/permissions).
  final List<String> $permissions;

  /// File name.
  final String name;

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
    required this.$createdAt,
    required this.$updatedAt,
    required this.$permissions,
    required this.name,
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
      $createdAt: map['\$createdAt'].toString(),
      $updatedAt: map['\$updatedAt'].toString(),
      $permissions: map['\$permissions'] ?? [],
      name: map['name'].toString(),
      signature: map['signature'].toString(),
      mimeType: map['mimeType'].toString(),
      sizeOriginal: map['sizeOriginal'],
      chunksTotal: map['chunksTotal'],
      chunksUploaded: map['chunksUploaded'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "\$id": $id,
      "bucketId": bucketId,
      "\$createdAt": $createdAt,
      "\$updatedAt": $updatedAt,
      "\$permissions": $permissions,
      "name": name,
      "signature": signature,
      "mimeType": mimeType,
      "sizeOriginal": sizeOriginal,
      "chunksTotal": chunksTotal,
      "chunksUploaded": chunksUploaded,
    };
  }
}
