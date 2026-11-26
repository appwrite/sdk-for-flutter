import 'package:appwrite/models.dart';
import 'package:appwrite/enums.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('VideoList', () {
    test('model', () {
      final model = VideoList(
        total: 5,
        videos: [],
      );

      final map = model.toMap();
      final result = VideoList.fromMap(map);

      expect(result.total, 5);
      expect(result.videos, []);
    });
  });
}
