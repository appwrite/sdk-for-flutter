part of '../appwrite.dart';

  /// The Messaging service allows you to send messages to any provider type
  /// (SMTP, push notification, SMS, etc.).
class Messaging extends Service {
  /// Initializes a [Messaging] service
  Messaging(super.client);

  /// Create a new subscriber.
  Future<models.Subscriber> createSubscriber({required String topicId, required String subscriberId, required String targetId}) async {
    final String apiPath = '/messaging/topics/{topicId}/subscribers'.replaceAll('{topicId}', topicId);

        final Map<String, dynamic> apiParams = {
            'subscriberId': subscriberId,
            'targetId': targetId,
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.post, path: apiPath, params: apiParams, headers: apiHeaders);

        return models.Subscriber.fromMap(res.data);

  }

  /// Delete a subscriber by its unique ID.
  Future deleteSubscriber({required String topicId, required String subscriberId}) async {
    final String apiPath = '/messaging/topics/{topicId}/subscribers/{subscriberId}'.replaceAll('{topicId}', topicId).replaceAll('{subscriberId}', subscriberId);

        final Map<String, dynamic> apiParams = {
        };

        final Map<String, String> apiHeaders = {
            'content-type': 'application/json',
        };

        final res = await client.call(HttpMethod.delete, path: apiPath, params: apiParams, headers: apiHeaders);

        return  res.data;

  }
}