part of appwrite.models;

class Log {
    late final String event;
    late final String ip;
    late final int time;
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

    Log({
        required this.event,
        required this.ip,
        required this.time,
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
    });

    factory Log.fromMap(Map<String, dynamic> map) {
        return Log(
            event: map['event'],
            ip: map['ip'],
            time: map['time'],
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
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "event": event,
            "ip": ip,
            "time": time,
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
        };
    }

}
