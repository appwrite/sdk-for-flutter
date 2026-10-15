part of 'appwrite.dart';

/// Helper to build MQTT topics for `Push`, level by level.
///
/// ```dart
/// Topic.path(['user', userId, 'notification']); // "user/123/notification"
/// Topic.path(['org', orgId]).path(['logs']); // "org/42/logs"
/// ```
class Topic {
  final List<String> _levels;

  Topic._(this._levels);

  /// Start a topic with the given levels, e.g. `Topic.path(['user', userId])`.
  static Topic path(List<String> levels) => Topic._(_topicLevelsOf(levels));

  @override
  String toString() => _levels.join('/');
}

/// Appends levels to a [Topic]: `Topic.path(['user']).path(['notification'])`.
extension TopicLevels on Topic {
  /// Append the given levels.
  Topic path(List<String> levels) =>
      Topic._([..._levels, ..._topicLevelsOf(levels)]);
}

/// Validate the levels passed to `path()`: a non-empty list of non-empty
/// strings, none holding the level separator `/` or the MQTT wildcards `+`
/// and `#`.
List<String> _topicLevelsOf(List<String> levels) {
  if (levels.isEmpty) {
    throw ArgumentError('path() needs at least one level');
  }
  for (var index = 0; index < levels.length; index++) {
    final level = levels[index];
    if (level.isEmpty) {
      throw ArgumentError('empty level at index $index');
    }
    if (level.contains('/')) {
      final parts = level.split('/').map((part) => "'$part'").join(', ');
      throw ArgumentError('"$level" contains "/", split it: path([$parts])');
    }
    if (level.contains('+')) {
      throw ArgumentError('"$level" contains "+", not allowed in a topic');
    }
    if (level.contains('#')) {
      throw ArgumentError('"$level" contains "#", not allowed in a topic');
    }
    if (level.contains('\u0000')) {
      throw ArgumentError('level at index $index contains a NUL character');
    }
  }
  return List.unmodifiable(levels);
}
