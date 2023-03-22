import 'package:sembast/timestamp.dart';

class QueuedWrite {
  QueuedWrite({
    this.key = '',
    required this.method,
    required this.path,
    required this.headers,
    required this.params,
    required this.cacheModel,
    required this.cacheKey,
    required this.cacheResponseIdKey,
    required this.cacheResponseContainerKey,
    this.previous,
  }) {
    this.queuedAt = Timestamp.now();
  }

  String key;
  late Timestamp queuedAt;
  String method;
  String path;
  Map<String, String> headers;
  Map<String, Object?> params;
  String cacheModel;
  String cacheKey;
  String cacheResponseIdKey;
  String cacheResponseContainerKey;
  Map<String, Object?>? previous;

  factory QueuedWrite.fromMap(Map<String, dynamic> map) {
    return QueuedWrite(
      key: map["key"],
      method: map["method"] as String,
      path: map["path"] as String,
      headers: (map['headers'] as Map<String, Object?>)
          .map((key, value) => MapEntry(key, value?.toString() ?? '')),
      params: map['params'] as Map<String, Object?>,
      cacheModel: map['cacheModel'] as String,
      cacheKey: map['cacheKey'] as String,
      cacheResponseIdKey: map['cacheResponseIdKey'],
      cacheResponseContainerKey: map['cacheResponseContainerKey'],
      previous: map['previous'] as Map<String, Object?>?,
    );
  }

  Map<String, dynamic> toMap() => {
        "queuedAt": queuedAt,
        "method": method,
        "path": path,
        "headers": headers,
        "params": params,
        "cacheModel": cacheModel,
        "cacheKey": cacheKey,
        "cacheResponseIdKey": cacheResponseIdKey,
        "cacheResponseContainerKey": cacheResponseContainerKey,
        "previous": previous,
      };
}
