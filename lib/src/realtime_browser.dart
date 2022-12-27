import 'dart:convert';
import 'dart:async';
import 'package:universal_html/html.dart' as html;
import 'package:web_socket_channel/html.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'realtime_subscription.dart';
import 'realtime_base.dart';
import 'client.dart';
import 'client_browser.dart';
import 'realtime_mixin.dart';

RealtimeBase createRealtime(Client client) => RealtimeBrowser(client);

class RealtimeBrowser extends RealtimeBase with RealtimeMixin {
  Map<String, dynamic>? lastMessage;

  RealtimeBrowser(Client client) {
    this.client = client;
    getWebSocket = _getWebSocket;
    getFallbackCookie = _getFallbackCookie;
  }

  Future<WebSocketChannel> _getWebSocket(Uri uri) async {
    await (client as ClientBrowser).init();
    return HtmlWebSocketChannel.connect(uri);
  }

  String? _getFallbackCookie() {
    final fallbackCookie = html.window.localStorage['cookieFallback'];
    if (fallbackCookie != null) {
      final cookie = Map<String, dynamic>.from(jsonDecode(fallbackCookie));
      return cookie.values.first;
    }
    return null;
  }

  @override
  RealtimeSubscription subscribe(List<String> channels) {
    return subscribeTo(channels);
  }
}
