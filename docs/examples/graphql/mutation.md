```dart
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

Graphql graphql = Graphql(client);

models.Any result = await graphql.mutation(
    query: {
        "query": "mutation { accountUpdateName(name: \"Walter\") { name } }"
    },
);
```
