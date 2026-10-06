```dart
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

Account account = Account(client);

models.Token result = await account.createMagicURLToken(
    userId: '<USER_ID>',
    email: 'email@example.com',
    url: 'https://example.com', // optional
    phrase: false, // optional
);
```
