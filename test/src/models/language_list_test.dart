import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LanguageList', () {

    test('model', () {
      final model = LanguageList(
        total: 5,
        languages: [],
      );

      final map = model.toMap();
      final result = LanguageList.fromMap(map);

      expect(result.total, 5);
      expect(result.languages, []);
    });
  });
}
