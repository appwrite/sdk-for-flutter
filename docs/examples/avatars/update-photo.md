```dart
import 'dart:io';
import 'package:appwrite/appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

Avatars avatars = Avatars(client);

Account result = await avatars.updatePhoto(
    file: InputFile(path: './path-to-files/image.jpg', filename: 'image.jpg'),
);
```
