```dart
import 'package:appwrite/appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

Advisor advisor = Advisor(client);

ReportList result = await advisor.listReports(
    queries: [], // optional
    total: false, // optional
);
```
