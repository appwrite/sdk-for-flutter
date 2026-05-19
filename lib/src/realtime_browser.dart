import 'realtime_subscription.dart';
import 'realtime_base.dart';
import 'client.dart';
import 'realtime_mixin.dart';

RealtimeBase createRealtime(ClientAuth client) => RealtimeBrowser(client);

class RealtimeBrowser extends RealtimeBase with RealtimeMixin {
  Map<String, dynamic>? lastMessage;

  RealtimeBrowser(ClientAuth client) {
    this.client = client;
    getWebSocket = client.realtimeWebSocket;
    getFallbackCookie = client.realtimeFallbackCookie;
  }

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
