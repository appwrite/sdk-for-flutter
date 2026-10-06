```dart
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

DocumentsDB documentsDB = DocumentsDB(client);

models.DocumentList result = await documentsDB.createDocuments(
    databaseId: '<DATABASE_ID>',
    collectionId: '<COLLECTION_ID>',
    documents: [
	    {
	        "\$id": "example1",
	        "username": "walter.obrien",
	        "email": "walter.obrien@example.com",
	        "fullName": "Walter O'Brien",
	        "age": 30,
	        "isAdmin": false
	    }
	],
    transactionId: '<TRANSACTION_ID>', // optional
);
```
