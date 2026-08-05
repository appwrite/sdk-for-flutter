```dart
import 'package:appwrite/appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

Organization organization = Organization(client);

AppInstallationList result = await organization.listInstallations(
    queries: [], // optional
    total: false, // optional
);
```
