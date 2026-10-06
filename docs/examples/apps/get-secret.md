```dart
import 'package:appwrite/appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

Apps apps = Apps(client);

AppSecret result = await apps.getSecret(
    appId: '<APP_ID>',
    secretId: '<SECRET_ID>',
);
```
