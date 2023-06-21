import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Log', () {

    test('model', () {
      final model = Log(
        event: 'account.sessions.create',
        userId: '610fc2f985ee0',
        userEmail: 'john@appwrite.io',
        userName: 'John Doe',
        mode: 'admin',
        ip: '127.0.0.1',
        time: '2020-10-15T06:38:00.000+00:00',
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
      );

      final map = model.toMap();
      final result = Log.fromMap(map);

      expect(result.event, 'account.sessions.create');
      expect(result.userId, '610fc2f985ee0');
      expect(result.userEmail, 'john@appwrite.io');
      expect(result.userName, 'John Doe');
      expect(result.mode, 'admin');
      expect(result.ip, '127.0.0.1');
      expect(result.time, '2020-10-15T06:38:00.000+00:00');
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
    });
  });
}
