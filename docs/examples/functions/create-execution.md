```dart
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:appwrite/enums.dart' as enums;

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

Functions functions = Functions(client);

models.Execution result = await functions.createExecution(
    functionId: '<FUNCTION_ID>',
    body: '<BODY>', // optional
    xasync: false, // optional
    path: '<PATH>', // optional
    method: enums.ExecutionMethod.gET, // optional
    headers: {}, // optional
    scheduledAt: '<SCHEDULED_AT>', // optional
);
```
