part of '../../models.dart';

/// Log
class Log implements Model {
  /// Event name.
  final String event;

  /// User ID.
  final String userId;

  /// User Email.
  final String userEmail;

  /// User Name.
  final String userName;

  /// API mode when event triggered.
  final String mode;

  /// IP session in use when the session was created.
  final String ip;

  /// Log creation date in ISO 8601 format.
  final String time;

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

  Log({
    required this.event,
    required this.userId,
    required this.userEmail,
    required this.userName,
    required this.mode,
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
      event: map['event'].toString(),
      userId: map['userId'].toString(),
      userEmail: map['userEmail'].toString(),
      userName: map['userName'].toString(),
      mode: map['mode'].toString(),
      ip: map['ip'].toString(),
      time: map['time'].toString(),
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
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "event": event,
      "userId": userId,
      "userEmail": userEmail,
      "userName": userName,
      "mode": mode,
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
