```dart
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

Functions functions = Functions(client);

models.ExecutionList result = await functions.listExecutions(
    functionId: '<FUNCTION_ID>',
    queries: [], // optional
    total: false, // optional
);
```
