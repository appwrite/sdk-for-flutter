```dart
import 'dart:io';
import 'dart:typed_data';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/enums.dart' as enums;

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

Videos videos = Videos(client);

// Downloading file
Uint8List bytes = await videos.getCaptionManifest(
    videoId: '<VIDEO_ID>',
    output: enums.VideoOutput.hls,
    captionId: '<CAPTION_ID>',
);

final file = File('path_to_file/filename.ext');
file.writeAsBytesSync(bytes);
```
