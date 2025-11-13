part of '../../enums.dart';

enum Output {
  jpg(value: 'jpg'),
  jpeg(value: 'jpeg'),
  png(value: 'png'),
  webp(value: 'webp'),
  heic(value: 'heic'),
  avif(value: 'avif'),
  gif(value: 'gif');

  const Output({required this.value});

  final String value;

  String toJson() => value;
}
