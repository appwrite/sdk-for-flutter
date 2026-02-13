part of '../../models.dart';

/// Session
class Session implements Model {
    /// Session ID.
    final String $id;

    /// Session creation date in ISO 8601 format.
    final String $createdAt;

    /// Session update date in ISO 8601 format.
    final String $updatedAt;

    /// User ID.
    final String userId;

    /// Session expiration date in ISO 8601 format.
    final String expire;

    /// Session Provider.
    final String provider;

    /// Session Provider User ID.
    final String providerUid;

    /// Session Provider Access Token.
    final String providerAccessToken;

    /// The date of when the access token expires in ISO 8601 format.
    final String providerAccessTokenExpiry;

    /// Session Provider Refresh Token.
    final String providerRefreshToken;

    /// IP in use when the session was created.
    final String ip;

    /// Operating system code name. View list of [available options](https://github.com/appwrite/appwrite/blob/master/docs/lists/os.json).
    final String osCode;

    /// Operating system name.
    final String osName;

    /// Operating system version.
    final String osVersion;

    /// Client type.
    final String clientType;

    /// Client code name. View list of [available options](https://github.com/appwrite/appwrite/blob/master/docs/lists/clients.json).
    final String clientCode;

    /// Client name.
    final String clientName;

    /// Client version.
    final String clientVersion;

    /// Client engine name.
    final String clientEngine;

    /// Client engine name.
    final String clientEngineVersion;

    /// Device name.
    final String deviceName;

    /// Device brand name.
    final String deviceBrand;

    /// Device model name.
    final String deviceModel;

    /// Country two-character ISO 3166-1 alpha code.
    final String countryCode;

    /// Country name.
    final String countryName;

    /// Returns true if this the current user session.
    final bool current;

    /// Returns a list of active session factors.
    final List<String> factors;

    /// Secret used to authenticate the user. Only included if the request was made with an API key
    final String secret;

    /// Most recent date in ISO 8601 format when the session successfully passed MFA challenge.
    final String mfaUpdatedAt;

    Session({
        required this.$id,
        required this.$createdAt,
        required this.$updatedAt,
        required this.userId,
        required this.expire,
        required this.provider,
        required this.providerUid,
        required this.providerAccessToken,
        required this.providerAccessTokenExpiry,
        required this.providerRefreshToken,
        required this.ip,
        required this.osCode,
        required this.osName,
        required this.osVersion,
        required this.clientType,
        required this.clientCode,
        required this.clientName,
        required this.clientVersion,
        required this.clientEngine,
        required this.clientEngineVersion,
        required this.deviceName,
        required this.deviceBrand,
        required this.deviceModel,
        required this.countryCode,
        required this.countryName,
        required this.current,
        required this.factors,
        required this.secret,
        required this.mfaUpdatedAt,
    });

    factory Session.fromMap(Map<String, dynamic> map) {
        return Session(
            $id: map['\$id'].toString(),
            $createdAt: map['\$createdAt'].toString(),
            $updatedAt: map['\$updatedAt'].toString(),
            userId: map['userId'].toString(),
            expire: map['expire'].toString(),
            provider: map['provider'].toString(),
            providerUid: map['providerUid'].toString(),
            providerAccessToken: map['providerAccessToken'].toString(),
            providerAccessTokenExpiry: map['providerAccessTokenExpiry'].toString(),
            providerRefreshToken: map['providerRefreshToken'].toString(),
            ip: map['ip'].toString(),
            osCode: map['osCode'].toString(),
            osName: map['osName'].toString(),
            osVersion: map['osVersion'].toString(),
            clientType: map['clientType'].toString(),
            clientCode: map['clientCode'].toString(),
            clientName: map['clientName'].toString(),
            clientVersion: map['clientVersion'].toString(),
            clientEngine: map['clientEngine'].toString(),
            clientEngineVersion: map['clientEngineVersion'].toString(),
            deviceName: map['deviceName'].toString(),
            deviceBrand: map['deviceBrand'].toString(),
            deviceModel: map['deviceModel'].toString(),
            countryCode: map['countryCode'].toString(),
            countryName: map['countryName'].toString(),
            current: map['current'],
            factors: List.from(map['factors'] ?? []),
            secret: map['secret'].toString(),
            mfaUpdatedAt: map['mfaUpdatedAt'].toString(),
        );
    }

    @override
    Map<String, dynamic> toMap() {
        return {
            "\$id": $id,
            "\$createdAt": $createdAt,
            "\$updatedAt": $updatedAt,
            "userId": userId,
            "expire": expire,
            "provider": provider,
            "providerUid": providerUid,
            "providerAccessToken": providerAccessToken,
            "providerAccessTokenExpiry": providerAccessTokenExpiry,
            "providerRefreshToken": providerRefreshToken,
            "ip": ip,
            "osCode": osCode,
            "osName": osName,
            "osVersion": osVersion,
            "clientType": clientType,
            "clientCode": clientCode,
            "clientName": clientName,
            "clientVersion": clientVersion,
            "clientEngine": clientEngine,
            "clientEngineVersion": clientEngineVersion,
            "deviceName": deviceName,
            "deviceBrand": deviceBrand,
            "deviceModel": deviceModel,
            "countryCode": countryCode,
            "countryName": countryName,
            "current": current,
            "factors": factors,
            "secret": secret,
            "mfaUpdatedAt": mfaUpdatedAt,
        };
    }
}
