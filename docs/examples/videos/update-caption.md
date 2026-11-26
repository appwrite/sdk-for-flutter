```dart
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

Videos videos = Videos(client);

models.VideoCaption result = await videos.updateCaption(
    videoId: '<VIDEO_ID>',
    captionId: '<CAPTION_ID>',
    bucketId: '<BUCKET_ID>', // optional
    fileId: '<FILE_ID>', // optional
    name: '<NAME>', // optional
    language: 'aar', // optional
    xdefault: false, // optional
);
```
