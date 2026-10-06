```dart
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

Oauth2 oauth2 = Oauth2(client);

models.Oauth2DeviceAuthorization result = await oauth2.createDeviceAuthorization(
    clientId: '<CLIENT_ID>', // optional
    scope: '<SCOPE>', // optional
    authorizationDetails: '<AUTHORIZATION_DETAILS>', // optional
    resource: '', // optional
    audience: '<AUDIENCE>', // optional
);
```
