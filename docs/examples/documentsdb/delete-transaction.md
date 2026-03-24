```dart
import 'package:appwrite/appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

DocumentsDB documentsDB = DocumentsDB(client);

await documentsDB.deleteTransaction(
    transactionId: '<TRANSACTION_ID>',
);
```
