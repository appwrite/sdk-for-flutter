part of '../../enums.dart';

enum Roles {
  admin(value: 'admin'),
  developer(value: 'developer'),
  owner(value: 'owner');

  const Roles({required this.value});

  final String value;

  String toJson() => value;
}
