```dart
import 'package:appwrite/appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

Account account = Account(client);

PaymentMethod result = await account.updatePaymentMethod(
    paymentMethodId: '<PAYMENT_METHOD_ID>',
    expiryMonth: 1,
    expiryYear: 2026,
    state: '<STATE>', // optional
);
```
