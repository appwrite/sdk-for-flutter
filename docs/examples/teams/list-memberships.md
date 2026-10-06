```dart
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

Teams teams = Teams(client);

models.MembershipList result = await teams.listMemberships(
    teamId: '<TEAM_ID>',
    queries: [], // optional
    search: '<SEARCH>', // optional
    total: false, // optional
);
```
