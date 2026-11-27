```dart
import 'dart:io';
import 'dart:typed_data';
import 'package:appwrite/appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

Storage storage = Storage(client);

// Downloading file
Uint8List bytes = await storage.getFileDownload(
    bucketId: '<BUCKET_ID>',
    fileId: '<FILE_ID>',
    token: '<TOKEN>', // optional
);

final file = File('path_to_file/filename.ext');
file.writeAsBytesSync(bytes);
```
