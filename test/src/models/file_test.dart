import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('File', () {

    test('model', () {
      final model = File(
        $id: '5e5ea5c16897e',
        bucketId: '5e5ea5c16897e',
        $read: [],
        $write: [],
        name: 'Pink.png',
        dateCreated: 1592981250,
        signature: '5d529fd02b544198ae075bd57c1762bb',
        mimeType: 'image/png',
        sizeOriginal: 17890,
        chunksTotal: 17890,
        chunksUploaded: 17890,
      );

      final map = model.toMap();
      final result = File.fromMap(map);

      expect(result.$id, '5e5ea5c16897e');
      expect(result.bucketId, '5e5ea5c16897e');
      expect(result.$read, []);
      expect(result.$write, []);
      expect(result.name, 'Pink.png');
      expect(result.dateCreated, 1592981250);
      expect(result.signature, '5d529fd02b544198ae075bd57c1762bb');
      expect(result.mimeType, 'image/png');
      expect(result.sizeOriginal, 17890);
      expect(result.chunksTotal, 17890);
      expect(result.chunksUploaded, 17890);
    });
  });
}
