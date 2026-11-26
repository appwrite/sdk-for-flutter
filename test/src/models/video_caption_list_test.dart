import 'package:appwrite/models.dart';
import 'package:appwrite/enums.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('VideoCaptionList', () {
    test('model', () {
      final model = VideoCaptionList(
        total: 5,
        captions: [],
      );

      final map = model.toMap();
      final result = VideoCaptionList.fromMap(map);

      expect(result.total, 5);
      expect(result.captions, []);
    });
  });
}
