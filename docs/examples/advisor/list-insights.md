```dart
import 'package:appwrite/appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

Advisor advisor = Advisor(client);

InsightList result = await advisor.listInsights(
    reportId: '<REPORT_ID>',
    queries: [], // optional
    total: false, // optional
);
```
