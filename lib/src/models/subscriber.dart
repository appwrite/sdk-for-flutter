part of '../../models.dart';

/// Subscriber
class Subscriber implements Model {
    /// Subscriber ID.
    final String $id;
    /// Subscriber creation time in ISO 8601 format.
    final String $createdAt;
    /// Subscriber update date in ISO 8601 format.
    final String $updatedAt;
    /// Target ID.
    final String targetId;
    /// Target.
    final Target target;
    /// Topic ID.
    final String userId;
    /// User Name.
    final String userName;
    /// Topic ID.
    final String topicId;
    /// The target provider type. Can be one of the following: `email`, `sms` or `push`.
    final String providerType;

    Subscriber({
        required this.$id,
        required this.$createdAt,
        required this.$updatedAt,
        required this.targetId,
        required this.target,
        required this.userId,
        required this.userName,
        required this.topicId,
        required this.providerType,
    });

    factory Subscriber.fromMap(Map<String, dynamic> map) {
        return Subscriber(
            $id: map['\$id'].toString(),
            $createdAt: map['\$createdAt'].toString(),
            $updatedAt: map['\$updatedAt'].toString(),
            targetId: map['targetId'].toString(),
            target: Target.fromMap(map['target']),
            userId: map['userId'].toString(),
            userName: map['userName'].toString(),
            topicId: map['topicId'].toString(),
            providerType: map['providerType'].toString(),
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "\$id": $id,
            "\$createdAt": $createdAt,
            "\$updatedAt": $updatedAt,
            "targetId": targetId,
            "target": target.toMap(),
            "userId": userId,
            "userName": userName,
            "topicId": topicId,
            "providerType": providerType,
        };
    }
}