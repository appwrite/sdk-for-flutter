```dart
import 'package:appwrite/appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProjectQuery('<YOUR_PROJECT_ID>'); // Your project ID

Oauth2 oauth2 = Oauth2(client);

Oauth2Reject result = await oauth2.reject(
    projectId: '<PROJECT_ID>',
    grantId: '<GRANT_ID>',
);
```
