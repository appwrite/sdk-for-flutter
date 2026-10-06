```dart
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

Account account = Account(client);

models.Target result = await account.createPushTarget(
    targetId: '<TARGET_ID>',
    identifier: '<IDENTIFIER>',
    providerId: '<PROVIDER_ID>', // optional
);
```
