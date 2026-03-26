part of '../../enums.dart';

enum Browser {
  avantBrowser(value: 'aa'),
  androidWebViewBeta(value: 'an'),
  googleChrome(value: 'ch'),
  googleChromeIOS(value: 'ci'),
  googleChromeMobile(value: 'cm'),
  chromium(value: 'cr'),
  mozillaFirefox(value: 'ff'),
  safari(value: 'sf'),
  mobileSafari(value: 'mf'),
  microsoftEdge(value: 'ps'),
  microsoftEdgeIOS(value: 'oi'),
  operaMini(value: 'om'),
  opera(value: 'op'),
  operaNext(value: 'on');

  const Browser({required this.value});

  final String value;

  String toJson() => value;
}
