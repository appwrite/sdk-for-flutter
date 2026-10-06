```dart
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

DocumentsDB documentsDB = DocumentsDB(client);

models.DocumentList result = await documentsDB.listDocuments(
    databaseId: '<DATABASE_ID>',
    collectionId: '<COLLECTION_ID>',
    queries: [], // optional
    transactionId: '<TRANSACTION_ID>', // optional
    total: false, // optional
    ttl: 0, // optional
);
```
