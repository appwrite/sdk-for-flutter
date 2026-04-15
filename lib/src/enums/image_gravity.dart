part of '../../enums.dart';

enum ImageGravity {
    center(value: 'center'),
    topLeft(value: 'top-left'),
    top(value: 'top'),
    topRight(value: 'top-right'),
    left(value: 'left'),
    right(value: 'right'),
    bottomLeft(value: 'bottom-left'),
    bottom(value: 'bottom'),
    bottomRight(value: 'bottom-right');

    const ImageGravity({
        required this.value
    });

    final String value;

    String toJson() => value;
}