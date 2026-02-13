```dart
import 'package:appwrite/appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

Organizations organizations = Organizations(client);

await organizations.delete(
    organizationId: '<ORGANIZATION_ID>',
);
```
