import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EstimationDeleteOrganization', () {
    test('model', () {
      final model = EstimationDeleteOrganization(
        unpaidInvoices: [],
      );

      final map = model.toMap();
      final result = EstimationDeleteOrganization.fromMap(map);

      expect(result.unpaidInvoices, []);
    });
  });
}
