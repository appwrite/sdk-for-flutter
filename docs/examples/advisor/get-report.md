```dart
import 'package:appwrite/appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

Advisor advisor = Advisor(client);

Report result = await advisor.getReport(
    reportId: '<REPORT_ID>',
);
```
