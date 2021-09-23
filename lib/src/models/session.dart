part of appwrite.models;

class Session {
    final String $id;
    final String userId;
    final int expire;
    final String provider;
    final String providerUid;
    final String providerToken;
    final String ip;
    final String osCode;
    final String osName;
    final String osVersion;
    final String clientType;
    final String clientCode;
    final String clientName;
    final String clientVersion;
    final String clientEngine;
    final String clientEngineVersion;
    final String deviceName;
    final String deviceBrand;
    final String deviceModel;
    final String countryCode;
    final String countryName;
    final bool current;

    Session({
        required this.$id,
        required this.userId,
        required this.expire,
        required this.provider,
        required this.providerUid,
        required this.providerToken,
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
    });

    factory Session.fromMap(Map<String, dynamic> map) {
        return Session(
            $id: map['\$id'],
            userId: map['userId'],
            expire: map['expire'],
            provider: map['provider'],
            providerUid: map['providerUid'],
            providerToken: map['providerToken'],
            ip: map['ip'],
            osCode: map['osCode'],
            osName: map['osName'],
            osVersion: map['osVersion'],
            clientType: map['clientType'],
            clientCode: map['clientCode'],
            clientName: map['clientName'],
            clientVersion: map['clientVersion'],
            clientEngine: map['clientEngine'],
            clientEngineVersion: map['clientEngineVersion'],
            deviceName: map['deviceName'],
            deviceBrand: map['deviceBrand'],
            deviceModel: map['deviceModel'],
            countryCode: map['countryCode'],
            countryName: map['countryName'],
            current: map['current'],
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "\$id": $id,
            "userId": userId,
            "expire": expire,
            "provider": provider,
            "providerUid": providerUid,
            "providerToken": providerToken,
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
        };
    }
}
