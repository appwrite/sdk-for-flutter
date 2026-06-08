part of '../../models.dart';

/// App
class App implements Model {
  /// App ID.
  final String $id;

  /// App creation time in ISO 8601 format.
  final String $createdAt;

  /// App update date in ISO 8601 format.
  final String $updatedAt;

  /// Application name.
  final String name;

  /// List of authorized redirect URIs. These URIs can be used to redirect users after they authenticate.
  final List<String> redirectUris;

  /// Whether the app is enabled or not.
  final bool enabled;

  /// OAuth2 client type. `public` for SPAs, mobile, and native apps that cannot keep a client secret (PKCE required); `confidential` for server-side clients that authenticate with a client secret.
  final String type;

  /// Whether this client may use the OAuth2 Device Authorization Grant (RFC 8628).
  final bool deviceFlow;

  /// ID of team that owns the application, if owned by team. Otherwise, user ID will be used.
  final String teamId;

  /// ID of user who owns the application, if owned by user. Otherwise, team ID will be used.
  final String userId;

  /// List of application secrets.
  final List<AppSecret> secrets;

  App({
    required this.$id,
    required this.$createdAt,
    required this.$updatedAt,
    required this.name,
    required this.redirectUris,
    required this.enabled,
    required this.type,
    required this.deviceFlow,
    required this.teamId,
    required this.userId,
    required this.secrets,
  });

  factory App.fromMap(Map<String, dynamic> map) {
    return App(
      $id: map['\$id'].toString(),
      $createdAt: map['\$createdAt'].toString(),
      $updatedAt: map['\$updatedAt'].toString(),
      name: map['name'].toString(),
      redirectUris: List.from(map['redirectUris'] ?? []),
      enabled: map['enabled'],
      type: map['type'].toString(),
      deviceFlow: map['deviceFlow'],
      teamId: map['teamId'].toString(),
      userId: map['userId'].toString(),
      secrets:
          List<AppSecret>.from(map['secrets'].map((p) => AppSecret.fromMap(p))),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "\$id": $id,
      "\$createdAt": $createdAt,
      "\$updatedAt": $updatedAt,
      "name": name,
      "redirectUris": redirectUris,
      "enabled": enabled,
      "type": type,
      "deviceFlow": deviceFlow,
      "teamId": teamId,
      "userId": userId,
      "secrets": secrets.map((p) => p.toMap()).toList(),
    };
  }
}
