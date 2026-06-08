part of '../../enums.dart';

enum BrowserTheme {
  light(value: 'light'),
  dark(value: 'dark');

  const BrowserTheme({required this.value});

  final String value;

  String toJson() => value;
}
