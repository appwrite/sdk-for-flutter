import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TemplateFunction', () {

    test('model', () {
      final model = TemplateFunction(
        icon: 'icon-lightning-bolt',
        id: 'starter',
        name: 'Starter function',
        tagline: 'A simple function to get started.',
        permissions: [],
        events: [],
        cron: '0 0 * * *',
        timeout: 300,
        useCases: [],
        runtimes: [],
        instructions: 'For documentation and instructions check out <link>.',
        vcsProvider: 'github',
        providerRepositoryId: 'templates',
        providerOwner: 'appwrite',
        providerVersion: 'main',
        variables: [],
        scopes: [],
      );

      final map = model.toMap();
      final result = TemplateFunction.fromMap(map);

      expect(result.icon, 'icon-lightning-bolt');
      expect(result.id, 'starter');
      expect(result.name, 'Starter function');
      expect(result.tagline, 'A simple function to get started.');
      expect(result.permissions, []);
      expect(result.events, []);
      expect(result.cron, '0 0 * * *');
      expect(result.timeout, 300);
      expect(result.useCases, []);
      expect(result.runtimes, []);
      expect(result.instructions, 'For documentation and instructions check out <link>.');
      expect(result.vcsProvider, 'github');
      expect(result.providerRepositoryId, 'templates');
      expect(result.providerOwner, 'appwrite');
      expect(result.providerVersion, 'main');
      expect(result.variables, []);
      expect(result.scopes, []);
    });
  });
}
