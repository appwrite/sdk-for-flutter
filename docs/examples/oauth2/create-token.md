```dart
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

Oauth2 oauth2 = Oauth2(client);

models.Oauth2Token result = await oauth2.createToken(
    grantType: '<GRANT_TYPE>',
    code: '<CODE>', // optional
    refreshToken: '<REFRESH_TOKEN>', // optional
    deviceCode: '<DEVICE_CODE>', // optional
    clientId: '<CLIENT_ID>', // optional
    clientSecret: '<CLIENT_SECRET>', // optional
    codeVerifier: '<CODE_VERIFIER>', // optional
    redirectUri: 'https://example.com', // optional
    resource: '', // optional
    audience: '<AUDIENCE>', // optional
);
```
