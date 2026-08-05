```dart
import 'package:appwrite/appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

Account account = Account(client);

Oauth2ConsentToken result = await account.getConsentToken(
    consentId: '<CONSENT_ID>',
    tokenId: '<TOKEN_ID>',
);
```
