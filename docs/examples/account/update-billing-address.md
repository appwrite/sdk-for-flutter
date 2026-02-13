```dart
import 'package:appwrite/appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

Account account = Account(client);

BillingAddress result = await account.updateBillingAddress(
    billingAddressId: '<BILLING_ADDRESS_ID>',
    country: '<COUNTRY>',
    city: '<CITY>',
    streetAddress: '<STREET_ADDRESS>',
    addressLine2: '<ADDRESS_LINE2>', // optional
    state: '<STATE>', // optional
    postalCode: '<POSTAL_CODE>', // optional
);
```
