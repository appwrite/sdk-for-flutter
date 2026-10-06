```dart
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:appwrite/enums.dart' as enums;

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

Account account = Account(client);

models.MfaChallenge result = await account.createMFAChallenge(
    factor: enums.AuthenticationFactor.email,
);
```
