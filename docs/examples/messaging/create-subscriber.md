```dart
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>'); // Your project ID

Messaging messaging = Messaging(client);

models.Subscriber result = await messaging.createSubscriber(
    topicId: '<TOPIC_ID>',
    subscriberId: '<SUBSCRIBER_ID>',
    targetId: '<TARGET_ID>',
);
```
