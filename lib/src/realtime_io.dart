import 'realtime_subscription.dart';
import 'realtime_base.dart';
import 'realtime_mixin.dart';
import 'client.dart';

RealtimeBase createRealtime(ClientAuth client) => RealtimeIO(client);

class RealtimeIO extends RealtimeBase with RealtimeMixin {

  RealtimeIO(ClientAuth client) {
    this.client = client;
    getWebSocket = client.realtimeWebSocket;
  }

  /// Subscribe
  ///
  /// Use this method to subscribe to a channels and listen to
  /// realtime events on those channels
  @override
  RealtimeSubscription subscribe(
    List<Object> channels, {
    List<String> queries = const [],
  }) {
    return subscribeTo(channels, queries);
  }

  @override
  void upsertPresence({
    required String status,
    required String presenceId,
    List<String>? permissions,
    Map<String, dynamic>? metadata,
  }) {
    upsertPresenceTo(
      status: status,
      presenceId: presenceId,
      permissions: permissions,
      metadata: metadata,
    );
  }
}
