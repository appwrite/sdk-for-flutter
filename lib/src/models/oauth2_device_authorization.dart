part of '../../models.dart';

/// OAuth2 Device Authorization
class Oauth2DeviceAuthorization implements Model {
  /// Device verification code used by the client to poll the token endpoint.
  final String device_code;

  /// Short code the end user enters on the verification page.
  final String user_code;

  /// URL where the end user enters the user code.
  final String verification_uri;

  /// Verification URL with the user code prefilled as a query parameter.
  final String verification_uri_complete;

  /// Lifetime of the device code and user code in seconds.
  final int expires_in;

  /// Minimum polling interval for the token endpoint in seconds.
  final int interval;

  Oauth2DeviceAuthorization({
    required this.device_code,
    required this.user_code,
    required this.verification_uri,
    required this.verification_uri_complete,
    required this.expires_in,
    required this.interval,
  });
  factory Oauth2DeviceAuthorization.fromMap(
    Map<String, dynamic> map,
  ) {
    return Oauth2DeviceAuthorization(
      device_code: map['device_code'].toString(),
      user_code: map['user_code'].toString(),
      verification_uri: map['verification_uri'].toString(),
      verification_uri_complete: map['verification_uri_complete'].toString(),
      expires_in: map['expires_in'],
      interval: map['interval'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "device_code": device_code,
      "user_code": user_code,
      "verification_uri": verification_uri,
      "verification_uri_complete": verification_uri_complete,
      "expires_in": expires_in,
      "interval": interval,
    };
  }
}
