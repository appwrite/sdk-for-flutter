```dart
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

Videos videos = Videos(client);

models.VideoRendition result = await videos.getRendition(
    videoId: '<VIDEO_ID>',
    renditionId: '<RENDITION_ID>',
);
```
