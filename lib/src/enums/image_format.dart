part of '../../enums.dart';

enum ImageFormat {
  jpg(value: 'jpg'),
  jpeg(value: 'jpeg'),
  gif(value: 'gif'),
  png(value: 'png'),
  webp(value: 'webp');

  const ImageFormat({required this.value});

  final String value;

  String toJson() => value;
}
