import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TemplateRuntime', () {

    test('model', () {
      final model = TemplateRuntime(
        name: 'node-19.0',
        commands: 'npm install',
        entrypoint: 'index.js',
        providerRootDirectory: 'node/starter',
      );

      final map = model.toMap();
      final result = TemplateRuntime.fromMap(map);

      expect(result.name, 'node-19.0');
      expect(result.commands, 'npm install');
      expect(result.entrypoint, 'index.js');
      expect(result.providerRootDirectory, 'node/starter');
    });
  });
}
