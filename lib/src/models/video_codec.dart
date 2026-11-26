part of '../../models.dart';

/// Video codec
class VideoCodec implements Model {
  /// Codec ID.
  final String $id;

  /// Codec display name.
  final String name;

  /// Streaming output formats this codec may be packaged into.
  final List<enums.VideoOutput> outputs;

  VideoCodec({
    required this.$id,
    required this.name,
    required this.outputs,
  });
  factory VideoCodec.fromMap(
    Map<String, dynamic> map,
  ) {
    map = {
      '\$id': "",
      'name': "",
      'outputs': [],
      ...map,
    };

    return VideoCodec(
      $id: map['\$id'].toString(),
      name: map['name'].toString(),
      outputs: List<enums.VideoOutput>.from(
        ((map['outputs'] is List) ? map['outputs'] : [map['outputs']]).map(
          (p) => enums.VideoOutput.values.firstWhere((e) => e.value == p),
        ),
      ),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "\$id": $id,
      "name": name,
      "outputs": outputs.map((p) => p.value).toList(),
    };
  }
}
