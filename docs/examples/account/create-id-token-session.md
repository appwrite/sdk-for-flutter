```dart
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/enums.dart' as enums;

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

Account account = Account(client);

Session result = await account.createIdTokenSession(
    provider: enums.IdTokenProvider.apple,
    idToken: '<ID_TOKEN>',
    nonce: '<NONCE>', // optional
    accessToken: '<ACCESS_TOKEN>', // optional
    accessTokenExpiry: 0, // optional
    name: '<NAME>', // optional
);
```
