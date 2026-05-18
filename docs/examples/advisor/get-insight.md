```dart
import 'package:appwrite/appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

Advisor advisor = Advisor(client);

Insight result = await advisor.getInsight(
    reportId: '<REPORT_ID>',
    insightId: '<INSIGHT_ID>',
);
```
