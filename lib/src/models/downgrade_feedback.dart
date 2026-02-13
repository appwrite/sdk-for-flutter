part of '../../models.dart';

/// Downgrade Feedback
class DowngradeFeedback implements Model {
  /// Feedback ID.
  final String $id;

  /// Feedback creation date in ISO 8601 format.
  final String $createdAt;

  /// Feedback update date in ISO 8601 format.
  final String $updatedAt;

  /// Feedback reason
  final String title;

  /// Feedback message
  final String message;

  /// Plan ID downgrading from
  final String fromPlanId;

  /// Plan ID downgrading to
  final String toPlanId;

  /// Organization ID
  final String teamId;

  /// User ID who submitted feedback
  final String userId;

  /// Console version
  final String version;

  DowngradeFeedback({
    required this.$id,
    required this.$createdAt,
    required this.$updatedAt,
    required this.title,
    required this.message,
    required this.fromPlanId,
    required this.toPlanId,
    required this.teamId,
    required this.userId,
    required this.version,
  });

  factory DowngradeFeedback.fromMap(Map<String, dynamic> map) {
    return DowngradeFeedback(
      $id: map['\$id'].toString(),
      $createdAt: map['\$createdAt'].toString(),
      $updatedAt: map['\$updatedAt'].toString(),
      title: map['title'].toString(),
      message: map['message'].toString(),
      fromPlanId: map['fromPlanId'].toString(),
      toPlanId: map['toPlanId'].toString(),
      teamId: map['teamId'].toString(),
      userId: map['userId'].toString(),
      version: map['version'].toString(),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "\$id": $id,
      "\$createdAt": $createdAt,
      "\$updatedAt": $updatedAt,
      "title": title,
      "message": message,
      "fromPlanId": fromPlanId,
      "toPlanId": toPlanId,
      "teamId": teamId,
      "userId": userId,
      "version": version,
    };
  }
}
