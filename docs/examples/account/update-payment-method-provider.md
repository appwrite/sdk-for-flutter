```dart
import 'package:appwrite/appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

Account account = Account(client);

PaymentMethod result = await account.updatePaymentMethodProvider(
    paymentMethodId: '<PAYMENT_METHOD_ID>',
    providerMethodId: '<PROVIDER_METHOD_ID>',
    name: '<NAME>',
    state: '<STATE>', // optional
);
```
