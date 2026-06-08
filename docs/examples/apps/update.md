```dart
import 'package:appwrite/appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

Apps apps = Apps(client);

App result = await apps.update(
    appId: '<APP_ID>',
    name: '<NAME>',
    enabled: false, // optional
    redirectUris: [], // optional
    type: 'public', // optional
    deviceFlow: false, // optional
);
```
