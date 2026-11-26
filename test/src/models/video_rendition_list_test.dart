import 'package:appwrite/models.dart';
import 'package:appwrite/enums.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('VideoRenditionList', () {
    test('model', () {
      final model = VideoRenditionList(
        total: 5,
        renditions: [],
      );

      final map = model.toMap();
      final result = VideoRenditionList.fromMap(map);

      expect(result.total, 5);
      expect(result.renditions, []);
    });
  });
}
