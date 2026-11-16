part of '../../models.dart';

/// Device
class Device implements Model {
  /// Device ID.
  final String $id;

  /// Device creation date in ISO 8601 format.
  final String $createdAt;

  /// Device update date in ISO 8601 format.
  final String $updatedAt;

  /// Device expiration date in ISO 8601 format.
  final String expire;

  /// ID of the session that is currently active on the device. Empty when no session is active, for example right after the active session was deleted.
  final String activeSessionId;

  /// List of sessions the device holds. Switch between them to change the active account.
  final List<Session> sessions;

  /// Secret used to authenticate the device. Carried by the device cookie; only included in the response if the request was made with an API key.
  final String secret;

  Device({
    required this.$id,
    required this.$createdAt,
    required this.$updatedAt,
    required this.expire,
    required this.activeSessionId,
    required this.sessions,
    required this.secret,
  });
  factory Device.fromMap(
    Map<String, dynamic> map,
  ) {
    map = {
      '\$id': "",
      '\$createdAt': "",
      '\$updatedAt': "",
      'expire': "",
      'activeSessionId': "",
      'sessions': [],
      'secret': "",
      ...map,
    };

    return Device(
      $id: map['\$id'].toString(),
      $createdAt: map['\$createdAt'].toString(),
      $updatedAt: map['\$updatedAt'].toString(),
      expire: map['expire'].toString(),
      activeSessionId: map['activeSessionId'].toString(),
      sessions: List<Session>.from(
        map['sessions'].map((p) => Session.fromMap(p)),
      ),
      secret: map['secret'].toString(),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "\$id": $id,
      "\$createdAt": $createdAt,
      "\$updatedAt": $updatedAt,
      "expire": expire,
      "activeSessionId": activeSessionId,
      "sessions": sessions.map((p) => p.toMap()).toList(),
      "secret": secret,
    };
  }
}
