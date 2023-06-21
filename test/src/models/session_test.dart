import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Session', () {

    test('model', () {
      final model = Session(
        $id: '5e5ea5c16897e',
        $createdAt: '2020-10-15T06:38:00.000+00:00',
        userId: '5e5bb8c16897e',
        expire: '2020-10-15T06:38:00.000+00:00',
        provider: 'email',
        providerUid: 'user@example.com',
        providerAccessToken: 'MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3',
        providerAccessTokenExpiry: '2020-10-15T06:38:00.000+00:00',
        providerRefreshToken: 'MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3',
        ip: '127.0.0.1',
        osCode: 'Mac',
        osName: 'Mac',
        osVersion: 'Mac',
        clientType: 'browser',
        clientCode: 'CM',
        clientName: 'Chrome Mobile iOS',
        clientVersion: '84.0',
        clientEngine: 'WebKit',
        clientEngineVersion: '605.1.15',
        deviceName: 'smartphone',
        deviceBrand: 'Google',
        deviceModel: 'Nexus 5',
        countryCode: 'US',
        countryName: 'United States',
        current: true,
      );

      final map = model.toMap();
      final result = Session.fromMap(map);

      expect(result.$id, '5e5ea5c16897e');
      expect(result.$createdAt, '2020-10-15T06:38:00.000+00:00');
      expect(result.userId, '5e5bb8c16897e');
      expect(result.expire, '2020-10-15T06:38:00.000+00:00');
      expect(result.provider, 'email');
      expect(result.providerUid, 'user@example.com');
      expect(result.providerAccessToken, 'MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3');
      expect(result.providerAccessTokenExpiry, '2020-10-15T06:38:00.000+00:00');
      expect(result.providerRefreshToken, 'MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3');
      expect(result.ip, '127.0.0.1');
      expect(result.osCode, 'Mac');
      expect(result.osName, 'Mac');
      expect(result.osVersion, 'Mac');
      expect(result.clientType, 'browser');
      expect(result.clientCode, 'CM');
      expect(result.clientName, 'Chrome Mobile iOS');
      expect(result.clientVersion, '84.0');
      expect(result.clientEngine, 'WebKit');
      expect(result.clientEngineVersion, '605.1.15');
      expect(result.deviceName, 'smartphone');
      expect(result.deviceBrand, 'Google');
      expect(result.deviceModel, 'Nexus 5');
      expect(result.countryCode, 'US');
      expect(result.countryName, 'United States');
      expect(result.current, true);
    });
  });
}
