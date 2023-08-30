import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProviderRepository', () {

    test('model', () {
      final model = ProviderRepository(
        id: '5e5ea5c16897e',
        name: 'appwrite',
        organization: 'appwrite',
        provider: 'github',
        private: true,
        runtime: 'node',
        pushedAt: 'datetime',
      );

      final map = model.toMap();
      final result = ProviderRepository.fromMap(map);

      expect(result.id, '5e5ea5c16897e');
      expect(result.name, 'appwrite');
      expect(result.organization, 'appwrite');
      expect(result.provider, 'github');
      expect(result.private, true);
      expect(result.runtime, 'node');
      expect(result.pushedAt, 'datetime');
    });
  });
}
