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

  /// Application description shown to users during OAuth2 consent.
  final String description;

  /// Application homepage URL shown to users during OAuth2 consent.
  final String clientUri;

  /// Application logo URL shown to users during OAuth2 consent.
  final String logoUri;

  /// Application privacy policy URL shown to users during OAuth2 consent.
  final String privacyPolicyUrl;

  /// Application terms of service URL shown to users during OAuth2 consent.
  final String termsUrl;

  /// Application support or security contact emails.
  final List<String> contacts;

  /// Application tagline shown to users during OAuth2 consent.
  final String tagline;

  /// Application tags shown to users during OAuth2 consent.
  final List<String> tags;

  /// Application labels. Read-only for clients; only a server SDK using a project API key can update them.
  final List<String> labels;

  /// Application image URLs shown to users during OAuth2 consent.
  final List<String> images;

  /// Application support URL shown to users during OAuth2 consent.
  final String supportUrl;

  /// Application data deletion URL shown to users during OAuth2 consent.
  final String dataDeletionUrl;

  /// List of authorized redirect URIs. These URIs can be used to redirect users after they authenticate.
  final List<String> redirectUris;

  /// List of authorized post-logout redirect URIs for OpenID Connect RP-Initiated Logout. The logout endpoint only redirects users to URIs in this list after ending their session.
  final List<String> postLogoutRedirectUris;

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

  /// Scopes the application requests when installed on a team. Organization-level and project-level scopes only.
  final List<String> installationScopes;

  /// URL users are redirected to after creating or updating an installation of this application. Empty for no redirect.
  final String installationRedirectUrl;

  /// List of application secrets.
  final List<AppSecret> secrets;

  App({
    required this.$id,
    required this.$createdAt,
    required this.$updatedAt,
    required this.name,
    required this.description,
    required this.clientUri,
    required this.logoUri,
    required this.privacyPolicyUrl,
    required this.termsUrl,
    required this.contacts,
    required this.tagline,
    required this.tags,
    required this.labels,
    required this.images,
    required this.supportUrl,
    required this.dataDeletionUrl,
    required this.redirectUris,
    required this.postLogoutRedirectUris,
    required this.enabled,
    required this.type,
    required this.deviceFlow,
    required this.teamId,
    required this.userId,
    required this.installationScopes,
    required this.installationRedirectUrl,
    required this.secrets,
  });
  factory App.fromMap(
    Map<String, dynamic> map,
  ) {
    return App(
      $id: map['\$id'].toString(),
      $createdAt: map['\$createdAt'].toString(),
      $updatedAt: map['\$updatedAt'].toString(),
      name: map['name'].toString(),
      description: map['description'].toString(),
      clientUri: map['clientUri'].toString(),
      logoUri: map['logoUri'].toString(),
      privacyPolicyUrl: map['privacyPolicyUrl'].toString(),
      termsUrl: map['termsUrl'].toString(),
      contacts: List.from(map['contacts'] ?? []),
      tagline: map['tagline'].toString(),
      tags: List.from(map['tags'] ?? []),
      labels: List.from(map['labels'] ?? []),
      images: List.from(map['images'] ?? []),
      supportUrl: map['supportUrl'].toString(),
      dataDeletionUrl: map['dataDeletionUrl'].toString(),
      redirectUris: List.from(map['redirectUris'] ?? []),
      postLogoutRedirectUris: List.from(map['postLogoutRedirectUris'] ?? []),
      enabled: map['enabled'],
      type: map['type'].toString(),
      deviceFlow: map['deviceFlow'],
      teamId: map['teamId'].toString(),
      userId: map['userId'].toString(),
      installationScopes: List.from(map['installationScopes'] ?? []),
      installationRedirectUrl: map['installationRedirectUrl'].toString(),
      secrets: List<AppSecret>.from(
        map['secrets'].map((p) => AppSecret.fromMap(p)),
      ),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "\$id": $id,
      "\$createdAt": $createdAt,
      "\$updatedAt": $updatedAt,
      "name": name,
      "description": description,
      "clientUri": clientUri,
      "logoUri": logoUri,
      "privacyPolicyUrl": privacyPolicyUrl,
      "termsUrl": termsUrl,
      "contacts": contacts,
      "tagline": tagline,
      "tags": tags,
      "labels": labels,
      "images": images,
      "supportUrl": supportUrl,
      "dataDeletionUrl": dataDeletionUrl,
      "redirectUris": redirectUris,
      "postLogoutRedirectUris": postLogoutRedirectUris,
      "enabled": enabled,
      "type": type,
      "deviceFlow": deviceFlow,
      "teamId": teamId,
      "userId": userId,
      "installationScopes": installationScopes,
      "installationRedirectUrl": installationRedirectUrl,
      "secrets": secrets.map((p) => p.toMap()).toList(),
    };
  }
}
