part of '../../models.dart';

/// Presence
class Presence implements Model {
    /// Presence ID.
    final String $id;

    /// Presence creation date in ISO 8601 format.
    final String $createdAt;

    /// Presence update date in ISO 8601 format.
    final String $updatedAt;

    /// Presence permissions. [Learn more about permissions](https://appwrite.io/docs/permissions).
    final List<String> $permissions;

    /// User ID.
    final String userId;

    /// Presence status.
    final String? status;

    /// Presence source.
    final String source;

    /// Presence expiry date in ISO 8601 format.
    final String? expiresAt;

    final Map<String, dynamic> metadata;

    Presence({
        required this.$id,
        required this.$createdAt,
        required this.$updatedAt,
        required this.$permissions,
        required this.userId,
        this.status,
        required this.source,
        this.expiresAt,
        required this.metadata,
    });

    factory Presence.fromMap(Map<String, dynamic> map) {
        return Presence(
            $id: map['\$id'].toString(),
            $createdAt: map['\$createdAt'].toString(),
            $updatedAt: map['\$updatedAt'].toString(),
            $permissions: List.from(map['\$permissions'] ?? []),
            userId: map['userId'].toString(),
            status: map['status']?.toString(),
            source: map['source'].toString(),
            expiresAt: map['expiresAt']?.toString(),
            metadata: map["metadata"] ?? map,
        );
    }

    @override
    Map<String, dynamic> toMap() {
        return {
            "\$id": $id,
            "\$createdAt": $createdAt,
            "\$updatedAt": $updatedAt,
            "\$permissions": $permissions,
            "userId": userId,
            "status": status,
            "source": source,
            "expiresAt": expiresAt,
            "metadata": metadata,
        };
    }

    T convertTo<T>(T Function(Map<String, dynamic>) fromJson) => fromJson(metadata);
}
