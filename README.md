# Appwrite Flutter SDK

[![pub package](https://img.shields.io/pub/v/appwrite?style=flat-square)](https://pub.dartlang.org/packages/appwrite)
![License](https://img.shields.io/badge/license-BSD--3--Clause-blue.svg?style=flat-square)
![Version](https://img.shields.io/badge/api%20version-2.5.x-blue.svg?style=flat-square)
[![X Account](https://img.shields.io/badge/follow-%40appwrite-000000?logo=x&style=flat-square)](https://x.com/appwrite)
[![Discord](https://img.shields.io/discord/564160730845151244?label=discord&style=flat-square)](https://appwrite.io/discord)

**This SDK targets Appwrite server version 2.5.x as shipped on Appwrite Cloud.** Self-hosted releases can lag behind Cloud — if you run an older self-hosted build, use a matching older SDK from [previous releases](https://github.com/appwrite/sdk-for-flutter/releases) when APIs differ.

Appwrite is an open-source backend as a service server that abstracts and simplifies complex and repetitive development tasks behind a very simple to use REST API. Appwrite aims to help you develop your apps faster and in a more secure way. Use the Flutter SDK to integrate your app with the Appwrite server to easily start interacting with all of Appwrite backend APIs and tools. For full API documentation and tutorials go to [https://appwrite.io/docs](https://appwrite.io/docs)

![Appwrite](https://github.com/appwrite/appwrite/raw/main/public/images/github.png)

## Installation

Add the package from the command line:

```bash
flutter pub add appwrite
```

Or add it to your app's `pubspec.yaml` file and run `flutter pub get`:

```yaml
dependencies:
  appwrite: ^28.0.0
```

### Android requirements

The SDK includes a native Android plugin, so it needs Android 7.0 (API 24) or later, and `flutter_local_notifications` needs core library desugaring. Apps with a lower `minSdk` or without desugaring fail to build. Desugaring is configured when the app is assembled, so a plugin cannot apply it for you. Add both to `android/app/build.gradle.kts`:

```kotlin
android {
    defaultConfig {
        minSdk = 24
    }
    compileOptions {
        isCoreLibraryDesugaringEnabled = true
    }
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}
```

## Getting Started

### Add your Flutter platform

Before the SDK can talk to your project, register each app you build in the Appwrite Console: open your project, choose **Add platform**, pick **Flutter**, then pick the target and enter its identifier. Register every target you ship separately.

| Target | Identifier |
| --- | --- |
| Android | Package name: the `applicationId` in `android/app/build.gradle.kts` |
| iOS | Bundle ID: Xcode, **Runner** target, **General** tab |
| macOS | Bundle ID: Xcode, **Runner** target, **General** tab |
| Linux | Package name: the `name` in `pubspec.yaml` |
| Windows | Package name: the `name` in `pubspec.yaml` |
| Web | Hostname your app is served from, such as `localhost` during development |

If a request fails because the platform is not registered, the error message includes the identifier the SDK sent, so you can copy it into the Console.

### Platform setup

#### Android

To return to your app after an OAuth2 login, add this activity inside the `<application>` tag of `android/app/src/main/AndroidManifest.xml`, alongside your existing activities. Replace `<PROJECT_ID>` with your Appwrite project ID.

```xml
<manifest ...>
    <application ...>
        <activity
            android:name="com.linusu.flutter_web_auth_2.CallbackActivity"
            android:exported="true"
            android:taskAffinity="">
            <intent-filter android:label="flutter_web_auth_2">
                <action android:name="android.intent.action.VIEW" />
                <category android:name="android.intent.category.DEFAULT" />
                <category android:name="android.intent.category.BROWSABLE" />
                <data android:scheme="appwrite-callback-<PROJECT_ID>" />
            </intent-filter>
        </activity>
    </application>
</manifest>
```

#### iOS

Set the iOS deployment target to 13.0 or later: in Xcode, open `ios/Runner.xcworkspace`, select the **Runner** target, and set **Minimum Deployments** on the **General** tab. OAuth2 login uses `ASWebAuthenticationSession` and needs no further setup.

#### macOS

Set the macOS deployment target to 10.15 or later in the **Runner** target's **General** tab. macOS apps run in the App Sandbox, which blocks network requests until you allow them. Add this key to both `macos/Runner/DebugProfile.entitlements` and `macos/Runner/Release.entitlements`:

```xml
<key>com.apple.security.network.client</key>
<true/>
```

#### Web

To complete an OAuth2 login on the web, create `web/auth.html` in your Flutter project. It sends the callback URL back to your app with `postMessage()`:

```html
<!DOCTYPE html>
<title>Authentication complete</title>
<p>Authentication is complete. If this does not happen automatically, please close the window.</p>
<script>
  function postAuthenticationMessage() {
    const message = {
      'flutter-web-auth-2': window.location.href
    };

    if (window.opener) {
      window.opener.postMessage(message, window.location.origin);
      window.close();
    } else if (window.parent && window.parent !== window) {
      window.parent.postMessage(message, window.location.origin);
    } else {
      localStorage.setItem('flutter-web-auth-2', window.location.href);
      window.close();
    }
  }

  postAuthenticationMessage();
</script>
```

Then pass that page as the `success` and `failure` URLs. It must be served from the same scheme, host and port as your app:

```dart
import 'package:appwrite/enums.dart' as enums;

await account.createOAuth2Session(
  provider: enums.OAuthProvider.github,
  success: '${Uri.base.origin}/auth.html',
  failure: '${Uri.base.origin}/auth.html',
);
```

Browsers block third-party cookies, so serve your app and Appwrite from the same registrable domain over HTTPS, for example with a [custom domain](https://appwrite.io/docs/products/network/custom-domains) for your Appwrite project. Otherwise requests after login can fail with a 401 error.

#### OAuth2 on Android, iOS and macOS

Call `createOAuth2Session` without the `success` and `failure` URLs. The SDK returns to your app only through the `appwrite-callback-<PROJECT_ID>` scheme, and only the default redirect carries the new session with it. A custom URL, such as an https App Link, makes the call fail (for example with `PlatformException(CANCELED)`) even when the login itself succeeded. Await the returned `Future` and navigate from your Dart code instead.

```dart
import 'package:appwrite/enums.dart' as enums;

await account.createOAuth2Session(provider: enums.OAuthProvider.github);
```

### Initialize the client

Initialize the client with your project's endpoint and ID, both found on your project's **Settings** page in the Console.

```dart
import 'package:appwrite/appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1')
    .setProject('<YOUR_PROJECT_ID>');
```

> If you self-host Appwrite, use your instance's endpoint instead. On an emulator or a device, `localhost` is the device itself, not your computer: use your computer's private IP address (for example `http://192.168.1.100/v1`) or a tunnel such as [ngrok](https://ngrok.com/). Call `setSelfSigned()` only in development, when the instance uses a self-signed certificate.

### Make a request

Every service takes the client in its constructor, and every method takes named parameters and returns a typed model from `package:appwrite/models.dart`.

```dart
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

Account account = Account(client);

models.User user = await account.create(
  userId: ID.unique(),
  email: 'email@example.com',
  password: 'password',
  name: "Walter O'Brien",
);

models.Session session = await account.createEmailPasswordSession(
  email: 'email@example.com',
  password: 'password',
);
```

### Error handling

The SDK throws an `AppwriteException` with `message`, `code`, `type` and `response` properties. Catch it to present the `message` to the user or to handle the error based on its `type`.

```dart
try {
  models.User user = await account.get();
} on AppwriteException catch (e) {
  print('${e.code} ${e.type}: ${e.message}');
}
```

### Learn more

- [Flutter quick start](https://appwrite.io/docs/quick-starts/flutter)
- [Client Flutter API reference](https://appwrite.io/docs/references/cloud/client-flutter/account)
- [Appwrite docs](https://appwrite.io/docs)
- [Discord community](https://appwrite.io/discord)
- [Appwrite Flutter playground](https://github.com/appwrite/playground-for-flutter)

## Push

`Push` delivers messages from Appwrite to your app over a persistent connection, without FCM or APNs. Subscribe to one or more topics and handle each message in a callback:

```dart
final push = Push(client);

final subscription = await push.subscribe('news', (message) {
  print('${message.topic}: ${message.data}');
});

subscription.unsubscribe();
```

### Background delivery on Android

A subscription with `background: true` keeps delivering after the app is backgrounded, killed or the device restarts, until it is unsubscribed or `push.close()` is called (do this on sign-out). The plugin saves the subscription, and a scheduled job and alarm wake the app every 15 to 60 seconds to reconnect; the broker replays what was sent in between (`retry: true`). While the app is not on screen, each message is posted as a notification that opens the app. It reconnects with the credential saved at subscribe time, so use a session rather than a short-lived JWT.

On Android 13 and later, the first background subscription asks the user for the `POST_NOTIFICATIONS` runtime permission. If they decline, the subscription still delivers to your callback but posts no notification. Notifications show the title, body and image sent with `createPush`, falling back to the subscription's `title` when only a body is sent. A push with no title or body, such as a data-only push, posts no notification and reaches your callback only. Messages that are not a JSON object show the subscription's `title` with the raw payload as body.

Notifications are posted while the app is backgrounded or closed. While it is on screen your callback shows the message, so none is posted unless the subscription passes `notifyInForeground: true`.

```dart
final subscription = await push.subscribe(
  'news',
  (message) => print(message.data),
  background: true,
  title: 'News',
);

// Optional: immediate delivery even after a kill and during Doze, with a quiet ongoing
// notification (call while the app is in the foreground).
await push.setForeground(true);
```

Foreground mode runs a `remoteMessaging` foreground service, which Google Play asks apps to declare in the Play Console. Apps that never enable it can remove the service from their merged manifest with `tools:node="remove"` on `io.appwrite.flutter.services.PushService` and `android.permission.FOREGROUND_SERVICE_REMOTE_MESSAGING`.

Set the notification icon with `<meta-data android:name="io.appwrite.flutter.push.notification_icon" android:resource="@drawable/..." />` in your `<application>`; without it a generic icon is used.

#### Delivery while the app is closed

Messages sent while the app is closed arrive at the next scheduled wake-up. While the device is awake that is about every 15 seconds, or about every 60 seconds once exact alarms are allowed; without exact alarms the wake-ups are inexact, so battery saver can defer them further. In Doze (screen off and idle for a while) Android limits background alarms, exact ones included, to about one every nine minutes, so a closed app can take several minutes to receive a message: allowing exact alarms makes wake-ups punctual, it does not lift Doze. For immediate delivery, also in Doze, use `push.setForeground(true)` (see above).

The SDK uses exact alarms on its own whenever the app may schedule them. To allow it:

1. Declare the permissions in your app's `AndroidManifest.xml`. Both are optional and subject to Google Play policy: `SCHEDULE_EXACT_ALARM` needs a declaration in the Play Console, and `USE_EXACT_ALARM` is reserved for alarm, clock and calendar apps (the SDK does not use it).

   ```xml
   <uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM" />
   <uses-permission android:name="android.permission.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS" />
   ```

2. On Android 13 and later the user has to allow exact alarms, under Settings > Apps > Special app access > Alarms & reminders. Android 12 grants a declared `SCHEDULE_EXACT_ALARM` automatically, and older versions need nothing. Check with `await push.backgroundStatus()`: when `bestEffort` is true, explain why to the user, then from a user action open that screen with `push.requestExactAlarms()`, or ask for the battery-optimisation exemption with `push.requestIgnoreBatteryOptimizations()`. Both return false when there is nothing to ask, including when the permission is not declared. The SDK never opens these screens on its own.

If `backgroundRestricted` is true, the user restricted the app's background usage and messages can wait until the app is opened. Exact alarms don't lift it, and neither does foreground mode: Android stops a restricted app's foreground service once it leaves the screen. Ask the user to choose Unrestricted in the app's battery settings (Settings > Apps > your app > Battery); granting the battery optimisation exemption also lets the SDK's alarms and jobs run, and `bestEffort` then reflects only the exact-alarm state. It is always false below Android 9.

If the user force-stops the app (Settings > Force stop, and on some devices swiping it away from recents), Android cancels its alarms and jobs: nothing is delivered until the app is opened again, and the broker then replays what was sent meanwhile.

### Opening a tapped notification

Read the `data` sent with `createPush` when the user taps a background notification:

```dart
// The tap that launched the app (reported once, so call it at startup).
final opened = await push.getInitialNotification();
if (opened != null) openSale(opened.data['saleId']);

// Taps while the app is running, including in the background.
final stop = push.onNotificationOpened((opened) => openSale(opened.data['saleId']));
```

On Android the SDK's native plugin reports the taps, on iOS `flutter_local_notifications`, and on the web the notification's click while the page is open.

## Contribution

This library is auto-generated by Appwrite custom [SDK Generator](https://github.com/appwrite/sdk-generator). To learn more about how you can help us improve this SDK, please check the [contribution guide](https://github.com/appwrite/sdk-generator/blob/main/CONTRIBUTING.md) before sending a pull-request.

## License

Please see the [BSD-3-Clause license](https://raw.githubusercontent.com/appwrite/appwrite/master/LICENSE) file for more information.
