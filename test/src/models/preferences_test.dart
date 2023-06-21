import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Preferences', () {

    test('model', () {
      final model = Preferences(
        data: {},
      );

      final map = model.toMap();
      final result = Preferences.fromMap(map);

    });
  });
}
