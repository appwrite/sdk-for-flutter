import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Document', () {

    test('model', () {
      final model = Document(
        $id: '5e5ea5c16897e',
        $collection: '5e5ea5c15117e',
        $read: [],
        $write: [],
        data: {},
      );

      final map = model.toMap();
      final result = Document.fromMap(map);

      expect(result.$id, '5e5ea5c16897e');
      expect(result.$collection, '5e5ea5c15117e');
      expect(result.$read, []);
      expect(result.$write, []);
    });
  });
}
