```dart
import 'package:appwrite/appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

DocumentsDB documentsDB = DocumentsDB(client);

Transaction result = await documentsDB.updateTransaction(
    transactionId: '<TRANSACTION_ID>',
    commit: false, // optional
    rollback: false, // optional
);
```
