```dart
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/permission.dart';
import 'package:appwrite/role.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

DocumentsDB documentsDB = DocumentsDB(client);

Document result = await documentsDB.updateDocument(
    databaseId: '<DATABASE_ID>',
    collectionId: '<COLLECTION_ID>',
    documentId: '<DOCUMENT_ID>',
    data: {}, // optional
    permissions: [Permission.read(Role.any())], // optional
    transactionId: '<TRANSACTION_ID>', // optional
);
```
