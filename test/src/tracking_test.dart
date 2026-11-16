import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/src/client_io.dart';
import 'package:appwrite/src/mqtt_native.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;

  late HttpServer server;
  late Directory documents;
  late ClientIO client;
  late Analytics analytics;
  late List<Map<String, dynamic>> events;
  late int status;
  final trackers = <Tracking>[];

  void appVersion(String version) => PackageInfo.setMockInitialValues(
    appName: 'app',
    packageName: 'io.example.app',
    version: version,
    buildNumber: '1',
    buildSignature: '',
  );

  File marker() => File('${documents.path}/appwrite_tracking_install');

  File pending() => File('${documents.path}/appwrite_tracking_pending');

  Tracking tracker() {
    final tracking = Tracking(analytics, 'property');
    trackers.add(tracking);
    return tracking;
  }

  // An app start in a new process.
  Future<void> start(String version) async {
    appVersion(version);
    Tracking.debugResetInstallCheck();
    tracker().start();
    await Tracking.debugInstallCheck;
  }

  setUp(() async {
    HttpOverrides.global = null;
    documents = await Directory.systemTemp.createTemp();
    messenger.setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/path_provider'),
      (call) async => documents.path,
    );

    events = [];
    status = 200;
    server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    server.listen((request) async {
      events.add(
        jsonDecode(await utf8.decoder.bind(request).join())
            as Map<String, dynamic>,
      );
      request.response
        ..statusCode = status
        ..headers.contentType = ContentType.json
        ..write('{}');
      await request.response.close();
    });

    client = ClientIO(endPoint: 'http://127.0.0.1:${server.port}/v1');
    client.config['project'] = 'project';
    analytics = Analytics(client);
  });

  tearDown(() async {
    for (final tracking in trackers) {
      tracking.disableAutoLifecycleEvents();
    }
    trackers.clear();
    messenger.setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/path_provider'),
      null,
    );
    await server.close(force: true);
    await documents.delete(recursive: true);
  });

  test('first_open is sent once per install', () async {
    await start('1.0.0');
    await start('1.0.0');

    expect(events, hasLength(1));
    expect(events.single['name'], 'first_open');
    expect(events.single['interactive'], false);
  });

  Future<void> saveCookies() async {
    final cookies = Directory('${documents.path}/cookies/ie0_ps1');
    await cookies.create(recursive: true);
    await File('${cookies.path}/.index').writeAsString('{}');
  }

  test('concurrent starts send one first_open', () async {
    appVersion('1.0.0');
    Tracking.debugResetInstallCheck();
    tracker().start();
    tracker().start();
    await Tracking.debugInstallCheck;

    expect(events.map((event) => event['name']), ['first_open']);
  });

  test('a failed first_open is retried on the next start', () async {
    status = 500;
    await start('1.0.0');
    expect(pending().existsSync(), isTrue);

    status = 200;
    await start('1.0.0');
    await start('1.0.0');

    expect(events.map((event) => event['name']), ['first_open', 'first_open']);
    expect(pending().existsSync(), isFalse);
  });

  test('a crash between the pending and marker writes sends once', () async {
    await marker().writeAsString('1.0.0');
    await pending().writeAsString(
      jsonEncode({
        'name': 'app_updated',
        'props': {'previousVersion': '1.0.0', 'version': '1.1.0'},
      }),
    );

    await start('1.1.0');
    await start('1.1.0');

    expect(events.map((event) => event['name']), ['app_updated']);
    expect(marker().readAsStringSync(), '1.1.0');
    expect(pending().existsSync(), isFalse);
  });

  test('a pending app_updated is carried to the current version', () async {
    await marker().writeAsString('1.0.0');
    status = 500;
    await start('1.1.0');
    events.clear();

    status = 200;
    await start('1.2.0');
    await start('1.2.0');

    expect(events, hasLength(1));
    expect(events.single['name'], 'app_updated');
    expect(events.single['props'], [
      'previousVersion',
      '1.0.0',
      'version',
      '1.2.0',
    ]);
    expect(marker().readAsStringSync(), '1.2.0');
    expect(pending().existsSync(), isFalse);
  });

  test('a rollback drops a pending app_updated', () async {
    await marker().writeAsString('1.0.0');
    status = 500;
    await start('1.1.0');
    events.clear();

    status = 200;
    await start('1.0.0');
    await start('1.0.0');

    expect(events, isEmpty);
    expect(marker().readAsStringSync(), '1.0.0');
    expect(pending().existsSync(), isFalse);
  });

  test('a pending first_open survives cookies saved meanwhile', () async {
    status = 500;
    await start('1.0.0');
    await saveCookies();

    status = 200;
    await start('1.0.0');

    expect(events.map((event) => event['name']), ['first_open', 'first_open']);
    expect(pending().existsSync(), isFalse);
  });

  test('an install that ran the SDK before gets no first_open', () async {
    await saveCookies();

    await start('1.0.0');

    expect(events, isEmpty);
    expect(marker().readAsStringSync(), '1.0.0');
  });

  test('app_updated is sent on the first start of a new version', () async {
    await marker().writeAsString('1.0.0');

    await start('1.1.0');
    await start('1.1.0');

    expect(events, hasLength(1));
    expect(events.single['name'], 'app_updated');
    expect(events.single['props'], [
      'previousVersion',
      '1.0.0',
      'version',
      '1.1.0',
    ]);
    expect(events.single['interactive'], false);
  });

  test('push helpers send messageId and campaign', () async {
    final tracking = Tracking(analytics, 'property');
    tracking.pushReceived(messageId: 'message');
    tracking.pushOpened(messageId: 'message', campaign: 'sale');
    while (events.length < 2) {
      await Future<void>.delayed(const Duration(milliseconds: 10));
    }

    final byName = {for (final event in events) event['name']: event};
    expect(byName['push_received']!['props'], ['messageId', 'message']);
    expect(byName['push_received']!['interactive'], false);
    expect(byName['push_opened']!['props'], [
      'messageId',
      'message',
      'campaign',
      'sale',
    ]);
    expect(byName['push_opened']!['interactive'], true);
  });

  Future<List<Map<String, dynamic>>> sent(int count) async {
    while (events.length < count) {
      await Future<void>.delayed(const Duration(milliseconds: 10));
    }
    await Future<void>.delayed(const Duration(milliseconds: 50));
    return events;
  }

  test('null props are dropped', () async {
    tracker().event('custom', props: {'plan': 'pro', 'coupon': null});

    expect((await sent(1)).single['props'], ['plan', 'pro']);
  });

  group('lifecycle', () {
    final binding = TestWidgetsFlutterBinding.instance;

    tearDown(
      () => binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed),
    );

    test('a background launch counts from its first foreground', () async {
      binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
      final tracking = tracker()..enableAutoLifecycleEvents();

      tracking.didChangeAppLifecycleState(AppLifecycleState.hidden);
      tracking.didChangeAppLifecycleState(AppLifecycleState.resumed);
      tracking.didChangeAppLifecycleState(AppLifecycleState.paused);

      // Requests run concurrently, so they can arrive in any order.
      expect(
        (await sent(2)).map((event) => event['name']),
        unorderedEquals(['app_foregrounded', 'app_backgrounded']),
      );
    });

    test('a foreground launch counts from the start', () async {
      binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      final tracking = tracker()..enableAutoLifecycleEvents();

      tracking.didChangeAppLifecycleState(AppLifecycleState.paused);

      expect((await sent(1)).map((event) => event['name']), [
        'app_backgrounded',
      ]);
    });
  });

  test('TrackingObserver skips a repeated screen', () async {
    Route<void> route(String name) => PageRouteBuilder<void>(
      settings: RouteSettings(name: name),
      pageBuilder: (_, _, _) => const SizedBox(),
    );
    final observer = TrackingObserver(tracker());
    final home = route('/home');
    final again = route('/home');

    observer.didPush(home, null);
    observer.didPush(again, home);
    observer.didPush(route('/sale'), again);

    final screens = await sent(2);
    expect(
      screens.map((event) => event['props']),
      unorderedEquals([
        ['screen', '/home', 'trigger', 'push'],
        ['screen', '/sale', 'trigger', 'push', 'previous', '/home'],
      ]),
    );
    expect(screens.map((event) => event['name']), [
      'screen_view',
      'screen_view',
    ]);
  });

  group('Push on Android', () {
    const channel = 'appwrite.push';
    late MockStreamHandlerEventSink nativeEvents;
    late List<String> hosted;
    late Push push;

    final payload = jsonEncode({
      'messageId': 'message',
      'notification': {'title': 'Sale'},
    });

    Future<void> settle() =>
        Future<void>.delayed(const Duration(milliseconds: 200));

    setUp(() async {
      hosted = [];
      messenger.setMockMethodCallHandler(const MethodChannel(channel), (
        call,
      ) async {
        if (call.method == 'host') {
          final subscriptions =
              jsonDecode((call.arguments as Map)['subscriptions'] as String)
                  as List;
          hosted = [for (final sub in subscriptions) sub['id'] as String];
          return true;
        }
        return call.method == 'hasSaved' ? false : null;
      });
      messenger.setMockStreamHandler(
        const EventChannel('$channel/events'),
        MockStreamHandler.inline(
          onListen: (_, sink) => nativeEvents = sink,
        ),
      );
      PushNative.debugInstance = PushNative.forMessenger(messenger);
      client.setJWT('jwt');
      push = Push(client).setTracking(Tracking(analytics, 'property'));
    });

    tearDown(() {
      push.close();
      PushNative.debugInstance = null;
      messenger.setMockMethodCallHandler(const MethodChannel(channel), null);
      messenger.setMockStreamHandler(
        const EventChannel('$channel/events'),
        null,
      );
    });

    test('push_opened is sent once per tap, whatever the listeners', () async {
      final opened = <String?>[];
      push.onNotificationOpened((tap) => opened.add(tap.messageId));
      push.onNotificationOpened((tap) => opened.add(tap.messageId));
      await settle();

      nativeEvents.success({
        'type': 'opened',
        'topic': 'users/user',
        'payload': payload,
      });
      await settle();

      expect(opened, ['message', 'message']);
      expect(events.map((event) => event['name']), ['push_opened']);
      expect(events.single['props'], ['messageId', 'message']);
    });

    test(
      'push_received is sent once per message, whatever the subscriptions',
      () async {
        final received = <String>[];
        await push.subscribe(
          'news',
          (message) => received.add(message.topic),
          background: true,
        );
        await push.subscribe(
          'news',
          (message) => received.add(message.topic),
          background: true,
        );
        expect(hosted, hasLength(2));

        for (final id in hosted) {
          nativeEvents.success({
            'type': 'message',
            'id': id,
            'topic': 'news',
            'payload': Uint8List.fromList(utf8.encode(payload)),
            'qos': 1,
            'ackToken': id,
          });
        }
        await settle();

        expect(received, ['news', 'news']);
        expect(events.map((event) => event['name']), ['push_received']);
        expect(events.single['props'], ['messageId', 'message']);
      },
    );
  });
}
