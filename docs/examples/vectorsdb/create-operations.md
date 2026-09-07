```dart
import 'package:appwrite/appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

VectorsDB vectorsDB = VectorsDB(client);

Transaction result = await vectorsDB.createOperations(
    transactionId: '<TRANSACTION_ID>',
    operations: [
	    {
	        "action": "create",
	        "databaseId": "<DATABASE_ID>",
	        "collectionId": "<COLLECTION_ID>",
	        "documentId": "<DOCUMENT_ID>",
	        "data": {
	            "name": "Walter O'Brien"
	        }
	    }
	], // optional
);
```
