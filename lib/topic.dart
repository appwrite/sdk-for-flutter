part of 'appwrite.dart';

/// Helper to build MQTT topics for `Push`, level by level.
///
/// ```dart
/// Topic.path(['user', userId, 'notification']); // "user/123/notification"
/// Topic.path(['user']).any().path(['notification']); // "user/+/notification"
/// Topic.path(['org']).any().path(['logs']).all(); // "org/+/logs/#"
/// ```
///
/// `any()` matches exactly one level and `all()` everything below, at any depth
/// (including the parent itself). `all()` ends the topic, so it returns a
/// [ResolvedTopic].
class Topic {
  final List<String> _levels;

  Topic._(this._levels);

  /// Start a topic with the given levels, e.g. `Topic.path(['user', userId])`.
  static Topic path(List<String> levels) => Topic._(_topicLevelsOf(levels));

  /// Start a topic with a single-level wildcard (`+`).
  static Topic any() => Topic._(const ['+']);

  /// The multi-level wildcard alone (`#`): matches every topic.
  static ResolvedTopic all() => ResolvedTopic._(const ['#']);

  @override
  String toString() => _levels.join('/');
}

/// Appends levels to a [Topic]: `Topic.path(['user']).any().path(['notification'])`.
extension TopicLevels on Topic {
  /// Append the given levels.
  Topic path(List<String> levels) =>
      Topic._([..._levels, ..._topicLevelsOf(levels)]);

  /// Append a single-level wildcard (`+`): matches exactly one level.
  Topic any() => Topic._([..._levels, '+']);

  /// Append the multi-level wildcard (`#`) and end the topic.
  ResolvedTopic all() => ResolvedTopic._([..._levels, '#']);
}

/// A topic ended by `all()`: nothing can be appended after the `#` wildcard.
class ResolvedTopic {
  final List<String> _levels;

  ResolvedTopic._(this._levels);

  @override
  String toString() => _levels.join('/');
}

/// Validate the levels passed to `path()`: a non-empty list of non-empty
/// strings, none holding the level separator `/` or the wildcards `+` and `#`
/// (use `any()` and `all()` for those).
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
    if (level == '+') {
      throw ArgumentError('"+" is reserved, use any()');
    }
    if (level.contains('+')) {
      throw ArgumentError('"$level" contains "+", use any() for wildcards');
    }
    if (level == '#') {
      throw ArgumentError('"#" is reserved, use all()');
    }
    if (level.contains('#')) {
      throw ArgumentError('"$level" contains "#", use all() for wildcards');
    }
  }
  return List.unmodifiable(levels);
}
