part of '../../enums.dart';

enum ImageFormat {
  jpg(value: 'jpg'),
  jpeg(value: 'jpeg'),
  png(value: 'png'),
  webp(value: 'webp'),
  heic(value: 'heic'),
  avif(value: 'avif');

  const ImageFormat({required this.value});

  final String value;

  String toJson() => value;
}
