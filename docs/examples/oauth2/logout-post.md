```dart
import 'package:appwrite/appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

Oauth2 oauth2 = Oauth2(client);

 result = await oauth2.logoutPost(
    idTokenHint: '<ID_TOKEN_HINT>', // optional
    logoutHint: '<LOGOUT_HINT>', // optional
    clientId: '<CLIENT_ID>', // optional
    postLogoutRedirectUri: 'https://example.com', // optional
    state: '<STATE>', // optional
    uiLocales: '<UI_LOCALES>', // optional
);
```
