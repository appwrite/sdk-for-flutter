```dart
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

Storage storage = Storage(client);

models.FileList result = await storage.listFiles(
    bucketId: '<BUCKET_ID>',
    queries: [], // optional
    search: '<SEARCH>', // optional
    total: false, // optional
);
```
