import 'package:flutter_test/flutter_test.dart';
import 'package:appwrite/src/mqtt.dart';

void main() {
  group('PushBackgroundStatus', () {
    test('fromMap should read backgroundRestricted', () {
      final status = PushBackgroundStatus.fromMap({
        'exactAlarms': true,
        'ignoringBatteryOptimizations': true,
        'foregroundService': true,
        'bestEffort': true,
        'backgroundRestricted': true,
      });

      expect(status.backgroundRestricted, isTrue);
      expect(status.bestEffort, isTrue);
      expect(status.exactAlarms, isTrue);
      expect(status.ignoringBatteryOptimizations, isTrue);
      expect(status.foregroundService, isTrue);
    });

    test('fromMap should default backgroundRestricted to false', () {
      final status = PushBackgroundStatus.fromMap({
        'exactAlarms': false,
        'ignoringBatteryOptimizations': false,
        'foregroundService': false,
        'bestEffort': true,
      });

      expect(status.backgroundRestricted, isFalse);
      expect(status.bestEffort, isTrue);
    });

    test('constructor should default backgroundRestricted to false', () {
      const status = PushBackgroundStatus(
        exactAlarms: true,
        ignoringBatteryOptimizations: false,
        foregroundService: false,
        bestEffort: false,
      );

      expect(status.backgroundRestricted, isFalse);
    });
  });
}
