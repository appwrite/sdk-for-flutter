part of '../../models.dart';

/// Target
class Target implements Model {
    /// Target ID.
    final String $id;
    /// Target creation time in ISO 8601 format.
    final String $createdAt;
    /// Target update date in ISO 8601 format.
    final String $updatedAt;
    /// Target Name.
    final String name;
    /// User ID.
    final String userId;
    /// Provider ID.
    final String? providerId;
    /// The target provider type. Can be one of the following: `email`, `sms` or `push`.
    final String providerType;
    /// The target identifier.
    final String identifier;

    Target({
        required this.$id,
        required this.$createdAt,
        required this.$updatedAt,
        required this.name,
        required this.userId,
        this.providerId,
        required this.providerType,
        required this.identifier,
    });

    factory Target.fromMap(Map<String, dynamic> map) {
        return Target(
            $id: map['\$id'].toString(),
            $createdAt: map['\$createdAt'].toString(),
            $updatedAt: map['\$updatedAt'].toString(),
            name: map['name'].toString(),
            userId: map['userId'].toString(),
            providerId: map['providerId']?.toString(),
            providerType: map['providerType'].toString(),
            identifier: map['identifier'].toString(),
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "\$id": $id,
            "\$createdAt": $createdAt,
            "\$updatedAt": $updatedAt,
            "name": name,
            "userId": userId,
            "providerId": providerId,
            "providerType": providerType,
            "identifier": identifier,
        };
    }
}
