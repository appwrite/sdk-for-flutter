import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProviderRepositoryList', () {

    test('model', () {
      final model = ProviderRepositoryList(
        total: 5,
        providerRepositories: [],
      );

      final map = model.toMap();
      final result = ProviderRepositoryList.fromMap(map);

      expect(result.total, 5);
      expect(result.providerRepositories, []);
    });
  });
}
