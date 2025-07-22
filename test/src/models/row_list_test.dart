import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RowList', () {

    test('model', () {
      final model = RowList(
        total: 5,
        rows: [],
      );

      final map = model.toMap();
      final result = RowList.fromMap(map);

      expect(result.total, 5);
      expect(result.rows, []);
    });
  });
}
