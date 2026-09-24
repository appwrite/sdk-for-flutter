part of '../../enums.dart';

enum IdTokenProvider {
  apple(value: "apple"),
  google(value: "google");

  const IdTokenProvider({required this.value});

  final String value;

  String toJson() => value;
}
