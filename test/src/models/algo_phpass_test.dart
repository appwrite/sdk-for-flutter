import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AlgoPhpass', () {

    test('model', () {
      final model = AlgoPhpass(
        type: 'phpass',
      );

      final map = model.toMap();
      final result = AlgoPhpass.fromMap(map);

      expect(result.type, 'phpass');
    });
  });
}
