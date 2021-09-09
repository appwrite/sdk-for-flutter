part of appwrite.models;

class Session {
    late final String $id;
    late final String userId;
    late final int expire;
    late final String provider;
    late final String providerUid;
    late final String providerToken;
    late final String ip;
    late final String osCode;
    late final String osName;
    late final String osVersion;
    late final String clientType;
    late final String clientCode;
    late final String clientName;
    late final String clientVersion;
    late final String clientEngine;
    late final String clientEngineVersion;
    late final String deviceName;
    late final String deviceBrand;
    late final String deviceModel;
    late final String countryCode;
    late final String countryName;
    late final bool current;

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
