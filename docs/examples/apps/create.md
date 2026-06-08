```dart
import 'package:appwrite/appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

Apps apps = Apps(client);

App result = await apps.create(
    appId: '<APP_ID>',
    name: '<NAME>',
    redirectUris: [],
    enabled: false, // optional
    type: 'public', // optional
    deviceFlow: false, // optional
    teamId: '<TEAM_ID>', // optional
);
```
