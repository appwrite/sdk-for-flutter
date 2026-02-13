import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BillingAddress', () {
    test('model', () {
      final model = BillingAddress(
        $id: 'eu-fr',
        userId: '5e5ea5c16897e',
        streetAddress: '13th Avenue',
        addressLine2: '',
        country: 'USA',
        city: '',
        state: '',
        postalCode: '',
      );

      final map = model.toMap();
      final result = BillingAddress.fromMap(map);

            expect(result.$id, 'eu-fr');
                  expect(result.userId, '5e5ea5c16897e');
                  expect(result.streetAddress, '13th Avenue');
                  expect(result.addressLine2, '');
                  expect(result.country, 'USA');
                  expect(result.city, '');
                  expect(result.state, '');
                  expect(result.postalCode, '');
          });
  });
}
