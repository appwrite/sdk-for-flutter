```dart
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/enums.dart' as enums;

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

Account account = Account(client);

Key result = await account.updateKey(
    keyId: '<KEY_ID>',
    name: '<NAME>',
    scopes: [enums.Scopes.account],
    expire: '', // optional
);
```
