```dart
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

Oauth2 oauth2 = Oauth2(client);

models.Oauth2PAR result = await oauth2.createPAR(
    clientId: '<CLIENT_ID>',
    redirectUri: 'https://example.com',
    responseType: 'code',
    scope: '<SCOPE>', // optional
    state: '<STATE>', // optional
    nonce: '<NONCE>', // optional
    codeChallenge: '<CODE_CHALLENGE>', // optional
    codeChallengeMethod: 's256', // optional
    prompt: '<PROMPT>', // optional
    maxAge: 0, // optional
    authorizationDetails: '<AUTHORIZATION_DETAILS>', // optional
    resource: '', // optional
    audience: '<AUDIENCE>', // optional
);
```
