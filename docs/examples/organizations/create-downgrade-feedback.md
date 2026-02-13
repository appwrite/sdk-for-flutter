```dart
import 'package:appwrite/appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

Organizations organizations = Organizations(client);

DowngradeFeedback result = await organizations.createDowngradeFeedback(
    organizationId: '<ORGANIZATION_ID>',
    reason: '<REASON>',
    message: '<MESSAGE>',
    fromPlanId: '<FROM_PLAN_ID>',
    toPlanId: '<TO_PLAN_ID>',
);
```
