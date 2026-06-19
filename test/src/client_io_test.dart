@TestOn('vm')
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:appwrite/src/client_io.dart';

class FakePathProvider extends PathProviderPlatform {
  @override
  Future<String?> getApplicationDocumentsPath() async => '/tmp/test_cookies';
}

void main() {
  group('ClientIO', () {
    setUp(() {
      PathProviderPlatform.instance = FakePathProvider();
    });

    test('constructor should not eagerly call init()', () {
      // Creating a ClientIO should NOT trigger init() immediately.
      // If init() is called eagerly, it causes "No JNI instance is available"
      // errors on Android in release mode because the platform channels
      // are not yet ready when the constructor runs.
      final client = ClientIO(
        endPoint: 'https://cloud.appwrite.io/v1',
        selfSigned: false,
      );

      // init() should not have been called yet - initialization should
      // be deferred until the first API call
      expect(client.initProgress, isFalse,
          reason: 'init() should not be called eagerly in the constructor');
      expect(client.initialized, isFalse,
          reason: 'Client should not be initialized until first API call');
    });

    test('init() should be called lazily on first API call', () async {
      final client = ClientIO(
        endPoint: 'https://cloud.appwrite.io/v1',
        selfSigned: false,
      );

      // Before any call, client should not be initialized
      expect(client.initialized, isFalse);

      // Trigger initialization by calling init() directly
      await client.init();

      // After init, client should be initialized
      expect(client.initialized, isTrue);
    });
  });
}
