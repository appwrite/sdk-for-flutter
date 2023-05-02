library jwt_decoder;

import 'dart:convert';

class JwtDecoder {
  static Map<String, dynamic> _decode(String token) {
    final splitToken = token.split(".");
    if (splitToken.length != 3) {
      throw FormatException('Invalid Token');
    }
    try {
      final payload =
          utf8.decode(base64.decode(base64.normalize(splitToken[1])));
      return jsonDecode(payload);
    } catch (error) {
      throw FormatException('Invalid Token');
    }
  }

  static bool isExpired(String token) {
    final decodedToken = _decode(token);
    final expiration = decodedToken['exp'] as int?;
    if (expiration == null) {
      return false;
    }
    final expiresOn = DateTime.fromMillisecondsSinceEpoch(expiration * 1000);
    return DateTime.now().isAfter(expiresOn);
  }
}
