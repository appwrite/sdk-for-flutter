import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AlgoScryptModified', () {

    test('model', () {
      final model = AlgoScryptModified(
        type: 'scryptMod',
        salt: 'UxLMreBr6tYyjQ==',
        saltSeparator: 'Bw==',
        signerKey: 'XyEKE9RcTDeLEsL/RjwPDBv/RqDl8fb3gpYEOQaPihbxf1ZAtSOHCjuAAa7Q3oHpCYhXSN9tizHgVOwn6krflQ==',
      );

      final map = model.toMap();
      final result = AlgoScryptModified.fromMap(map);

      expect(result.type, 'scryptMod');
      expect(result.salt, 'UxLMreBr6tYyjQ==');
      expect(result.saltSeparator, 'Bw==');
      expect(result.signerKey, 'XyEKE9RcTDeLEsL/RjwPDBv/RqDl8fb3gpYEOQaPihbxf1ZAtSOHCjuAAa7Q3oHpCYhXSN9tizHgVOwn6krflQ==');
    });
  });
}
