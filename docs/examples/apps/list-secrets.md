```dart
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

Apps apps = Apps(client);

models.AppSecretList result = await apps.listSecrets(
    appId: '<APP_ID>',
    queries: [], // optional
    total: false, // optional
);
```
