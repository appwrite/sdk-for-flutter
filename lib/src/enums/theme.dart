part of '../../enums.dart';

enum Theme {
  light(value: 'light'),
  dark(value: 'dark');

  const Theme({required this.value});

  final String value;

  String toJson() => value;
}
