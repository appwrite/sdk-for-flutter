```dart
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

Oauth2 oauth2 = Oauth2(client);

models.Oauth2ProjectList result = await oauth2.listProjects(
    limit: 1, // optional
    offset: 0, // optional
    search: '<SEARCH>', // optional
);
```
