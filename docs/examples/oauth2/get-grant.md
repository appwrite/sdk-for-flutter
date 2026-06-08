```dart
import 'package:appwrite/appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

Oauth2 oauth2 = Oauth2(client);

Oauth2Grant result = await oauth2.getGrant(
    projectId: '<PROJECT_ID>',
    grantId: '<GRANT_ID>',
);
```
