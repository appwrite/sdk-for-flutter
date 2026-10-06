```dart
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

Storage storage = Storage(client);

models.File result = await storage.getFile(
    bucketId: '<BUCKET_ID>',
    fileId: '<FILE_ID>',
);
```
