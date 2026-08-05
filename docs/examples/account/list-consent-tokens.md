```dart
import 'package:appwrite/appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

Account account = Account(client);

Oauth2ConsentTokenList result = await account.listConsentTokens(
    consentId: '<CONSENT_ID>',
    queries: [], // optional
    total: false, // optional
);
```
