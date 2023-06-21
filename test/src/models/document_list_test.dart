import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DocumentList', () {

    test('model', () {
      final model = DocumentList(
        total: 5,
        documents: [],
      );

      final map = model.toMap();
      final result = DocumentList.fromMap(map);

      expect(result.total, 5);
      expect(result.documents, []);
    });
  });
}
