```dart
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

Organization organization = Organization(client);

models.AppInstallation result = await organization.createInstallation(
    appId: '<APP_ID>',
    authorizationDetails: '<AUTHORIZATION_DETAILS>', // optional
);
```
