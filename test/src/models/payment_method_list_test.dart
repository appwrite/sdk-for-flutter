import 'package:appwrite/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PaymentMethodList', () {
    test('model', () {
      final model = PaymentMethodList(
        total: 5,
        paymentMethods: [],
      );

      final map = model.toMap();
      final result = PaymentMethodList.fromMap(map);

      expect(result.total, 5);
      expect(result.paymentMethods, []);
    });
  });
}
