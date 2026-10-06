```dart
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

Teams teams = Teams(client);

models.AppInstallation result = await teams.updateInstallation(
    teamId: '<TEAM_ID>',
    installationId: '<INSTALLATION_ID>',
    authorizationDetails: '<AUTHORIZATION_DETAILS>', // optional
);
```
