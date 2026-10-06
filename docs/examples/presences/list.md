```dart
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

Presences presences = Presences(client);

models.PresenceList result = await presences.list(
    queries: [], // optional
    total: false, // optional
    ttl: 0, // optional
);
```
