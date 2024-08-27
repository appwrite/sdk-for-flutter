import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'cookie_manager.dart';
import 'realtime_subscription.dart';
import 'realtime_base.dart';
import 'realtime_mixin.dart';
import 'client.dart';
import 'client_io.dart';

RealtimeBase createRealtime(Client client) => RealtimeIO(client);

class RealtimeIO extends RealtimeBase with RealtimeMixin {
  RealtimeIO(Client client) {
    this.client = client;
    getWebSocket = _getWebSocket;
  }

  Future<WebSocketChannel> _getWebSocket(Uri uri) async {
    Map<String, String>? headers;
    while (!(client as ClientIO).initialized &&
        (client as ClientIO).initProgress) {
      await Future.delayed(Duration(milliseconds: 10));
    }
    if (!(client as ClientIO).initialized) {
      await (client as ClientIO).init();
    }
    final cookies = await (client as ClientIO).cookieJar.loadForRequest(uri);
    headers = {HttpHeaders.cookieHeader: CookieManager.getCookies(cookies)};

    final _websok = IOWebSocketChannel((client as ClientIO).selfSigned
        ? await _connectForSelfSignedCert(uri, headers)
        : await WebSocket.connect(uri.toString(), headers: headers));
    return _websok;
  }

  /// Subscribe
  ///
  /// Use this method to subscribe to a channels and listen to
  /// realtime events on those channels
  @override
  RealtimeSubscription subscribe(List<String> channels) {
    return subscribeTo(channels);
  }

  // https://github.com/jonataslaw/getsocket/blob/f25b3a264d8cc6f82458c949b86d286cd0343792/lib/src/io.dart#L104
  // and from official dart sdk websocket_impl.dart connect method
  Future<WebSocket> _connectForSelfSignedCert(
      Uri uri, Map<String, dynamic> headers) async {
    try {
      var r = Random();
      var key = base64.encode(List<int>.generate(16, (_) => r.nextInt(255)));
      var client = HttpClient(context: SecurityContext());
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        debugPrint('AppwriteRealtime: Allow self-signed certificate');
        return true;
      };

      uri = Uri(
        scheme: uri.scheme == 'wss' ? 'https' : 'http',
        userInfo: uri.userInfo,
        host: uri.host,
        port: uri.port,
        path: uri.path,
        query: uri.query,
        fragment: uri.fragment,
      );

      var request = await client.getUrl(uri);

      headers.forEach((key, value) => request.headers.add(key, value));

      request.headers
        ..set(HttpHeaders.connectionHeader, "Upgrade")
        ..set(HttpHeaders.upgradeHeader, "websocket")
        ..set("Sec-WebSocket-Key", key)
        ..set("Cache-Control", "no-cache")
        ..set("Sec-WebSocket-Version", "13");

      var response = await request.close();

      // ignore: close_sinks
      var socket = await response.detachSocket();
      var webSocket = WebSocket.fromUpgradedSocket(socket, serverSide: false);
      return webSocket;
    } catch (e) {
      rethrow;
    }
  }
}
