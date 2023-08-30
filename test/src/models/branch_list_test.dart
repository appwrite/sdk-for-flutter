import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BranchList', () {

    test('model', () {
      final model = BranchList(
        total: 5,
        branches: [],
      );

      final map = model.toMap();
      final result = BranchList.fromMap(map);

      expect(result.total, 5);
      expect(result.branches, []);
    });
  });
}
