```dart
import 'package:appwrite/appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProjectQuery('<YOUR_PROJECT_ID>'); // Your project ID

Oauth2 oauth2 = Oauth2(client);

Oauth2Authorize result = await oauth2.authorize(
    projectId: '<PROJECT_ID>',
    clientId: '<CLIENT_ID>',
    redirectUri: 'https://example.com',
    responseType: 'code',
    scope: '<SCOPE>',
    state: '<STATE>', // optional
    nonce: '<NONCE>', // optional
    codeChallenge: '<CODE_CHALLENGE>', // optional
    codeChallengeMethod: 's256', // optional
    prompt: '<PROMPT>', // optional
    maxAge: 0, // optional
    authorizationDetails: '<AUTHORIZATION_DETAILS>', // optional
);
```
