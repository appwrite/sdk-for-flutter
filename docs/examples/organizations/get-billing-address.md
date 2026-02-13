```dart
import 'package:appwrite/appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

Organizations organizations = Organizations(client);

BillingAddress result = await organizations.getBillingAddress(
    organizationId: '<ORGANIZATION_ID>',
    billingAddressId: '<BILLING_ADDRESS_ID>',
);
```
