import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PaymentMethod', () {
    test('model', () {
      final model = PaymentMethod(
        $id: '5e5ea5c16897e',
        $createdAt: '2020-10-15T06:38:00.000+00:00',
        $updatedAt: '2020-10-15T06:38:00.000+00:00',
        $permissions: [],
        providerMethodId: 'abdk3ed3sdkfj',
        clientSecret: 'seti_ddfe',
        providerUserId: 'abdk3ed3sdkfj',
        userId: '5e5ea5c16897e',
        expiryMonth: 2,
        expiryYear: 2024,
        last4: '4242',
        brand: 'visa',
        name: 'John Doe',
        mandateId: 'yxc',
        country: 'de',
        state: '',
        lastError: 'Your card has insufficient funds.',
        xdefault: true,
        expired: true,
        failed: true,
      );

      final map = model.toMap();
      final result = PaymentMethod.fromMap(map);

            expect(result.$id, '5e5ea5c16897e');
                  expect(result.$createdAt, '2020-10-15T06:38:00.000+00:00');
                  expect(result.$updatedAt, '2020-10-15T06:38:00.000+00:00');
                  expect(result.$permissions, []);
                  expect(result.providerMethodId, 'abdk3ed3sdkfj');
                  expect(result.clientSecret, 'seti_ddfe');
                  expect(result.providerUserId, 'abdk3ed3sdkfj');
                  expect(result.userId, '5e5ea5c16897e');
                  expect(result.expiryMonth, 2);
                  expect(result.expiryYear, 2024);
                  expect(result.last4, '4242');
                  expect(result.brand, 'visa');
                  expect(result.name, 'John Doe');
                  expect(result.mandateId, 'yxc');
                  expect(result.country, 'de');
                  expect(result.state, '');
                  expect(result.lastError, 'Your card has insufficient funds.');
                  expect(result.xdefault, true);
                  expect(result.expired, true);
                  expect(result.failed, true);
          });
  });
}
