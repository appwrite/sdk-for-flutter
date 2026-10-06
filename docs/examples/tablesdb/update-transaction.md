```dart
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

TablesDB tablesDB = TablesDB(client);

models.Transaction result = await tablesDB.updateTransaction(
    transactionId: '<TRANSACTION_ID>',
    commit: false, // optional
    rollback: false, // optional
);
```
