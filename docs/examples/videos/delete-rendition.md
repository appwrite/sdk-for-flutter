```dart
import 'package:appwrite/appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

Videos videos = Videos(client);

await videos.deleteRendition(
    videoId: '<VIDEO_ID>',
    renditionId: '<RENDITION_ID>',
);
```
