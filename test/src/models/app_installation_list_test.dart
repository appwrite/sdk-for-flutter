import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppInstallationList', () {
    test('model', () {
      final model = AppInstallationList(
        total: 5,
        installations: [],
      );

      final map = model.toMap();
      final result = AppInstallationList.fromMap(map);

      expect(result.total, 5);
      expect(result.installations, []);
    });
  });
}
