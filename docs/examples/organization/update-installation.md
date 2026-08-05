```dart
import 'package:appwrite/appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

Organization organization = Organization(client);

AppInstallation result = await organization.updateInstallation(
    installationId: '<INSTALLATION_ID>',
    authorizationDetails: '<AUTHORIZATION_DETAILS>', // optional
);
```
