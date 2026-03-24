```dart
import 'package:appwrite/appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

DocumentsDB documentsDB = DocumentsDB(client);

Document result = await documentsDB.incrementDocumentAttribute(
    databaseId: '<DATABASE_ID>',
    collectionId: '<COLLECTION_ID>',
    documentId: '<DOCUMENT_ID>',
    attribute: '',
    value: 0, // optional
    max: 0, // optional
    transactionId: '<TRANSACTION_ID>', // optional
);
```
