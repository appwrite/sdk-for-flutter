import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BillingAddressList', () {
    test('model', () {
      final model = BillingAddressList(
        total: 5,
        billingAddresses: [],
      );

      final map = model.toMap();
      final result = BillingAddressList.fromMap(map);

            expect(result.total, 5);
                  expect(result.billingAddresses, []);
          });
  });
}
