import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PhoneList', () {

    test('model', () {
      final model = PhoneList(
        total: 5,
        phones: [],
      );

      final map = model.toMap();
      final result = PhoneList.fromMap(map);

      expect(result.total, 5);
      expect(result.phones, []);
    });
  });
}
