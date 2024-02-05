part of appwrite.models;

/// MFAProvider
class MfaProvider implements Model {
    /// Backup codes.
    final List backups;
    /// Secret token used for TOTP factor.
    final String secret;
    /// URI for authenticator apps.
    final String uri;

    MfaProvider({
        required this.backups,
        required this.secret,
        required this.uri,
    });

    factory MfaProvider.fromMap(Map<String, dynamic> map) {
        return MfaProvider(
            backups: map['backups'],
            secret: map['secret'].toString(),
            uri: map['uri'].toString(),
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "backups": backups,
            "secret": secret,
            "uri": uri,
        };
    }
}
