import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Invoice', () {
    test('model', () {
      final model = Invoice(
        $id: '5e5ea5c16897e',
        $createdAt: '2020-10-15T06:38:00.000+00:00',
        $updatedAt: '2020-10-15T06:38:00.000+00:00',
        $permissions: [],
        teamId: '5e5ea5c16897e',
        aggregationId: '5e5ea5c16897e',
        plan: 'tier-1',
        usage: [],
        amount: 50,
        tax: 17,
        taxAmount: 12.5,
        vat: 17,
        vatAmount: 12.5,
        grossAmount: 12.5,
        creditsUsed: 30,
        currency: 'USD',
        clientSecret: 'pi_daslfasdfkla_asdkfl',
        status: 'succeeded',
        lastError: 'Your card has insufficient balance.',
        dueAt: '2020-10-15T06:38:00.000+00:00',
        from: '2020-10-15T06:38:00.000+00:00',
        to: '2020-10-15T06:38:00.000+00:00',
      );

      final map = model.toMap();
      final result = Invoice.fromMap(map);

            expect(result.$id, '5e5ea5c16897e');
                  expect(result.$createdAt, '2020-10-15T06:38:00.000+00:00');
                  expect(result.$updatedAt, '2020-10-15T06:38:00.000+00:00');
                  expect(result.$permissions, []);
                  expect(result.teamId, '5e5ea5c16897e');
                  expect(result.aggregationId, '5e5ea5c16897e');
                  expect(result.plan, 'tier-1');
                  expect(result.usage, []);
                  expect(result.amount, 50);
                  expect(result.tax, 17);
                  expect(result.taxAmount, 12.5);
                  expect(result.vat, 17);
                  expect(result.vatAmount, 12.5);
                  expect(result.grossAmount, 12.5);
                  expect(result.creditsUsed, 30);
                  expect(result.currency, 'USD');
                  expect(result.clientSecret, 'pi_daslfasdfkla_asdkfl');
                  expect(result.status, 'succeeded');
                  expect(result.lastError, 'Your card has insufficient balance.');
                  expect(result.dueAt, '2020-10-15T06:38:00.000+00:00');
                  expect(result.from, '2020-10-15T06:38:00.000+00:00');
                  expect(result.to, '2020-10-15T06:38:00.000+00:00');
          });
  });
}
