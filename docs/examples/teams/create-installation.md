```dart
import 'package:appwrite/appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

Teams teams = Teams(client);

AppInstallation result = await teams.createInstallation(
    teamId: '<TEAM_ID>',
    appId: '<APP_ID>',
    authorizationDetails: '<AUTHORIZATION_DETAILS>', // optional
);
```
