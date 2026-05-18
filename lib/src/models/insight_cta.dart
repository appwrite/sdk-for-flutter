part of '../../models.dart';

/// InsightCTA
class InsightCTA implements Model {
  /// Human-readable label for the CTA, used in UI.
  final String label;

  /// Public API service (SDK namespace) the client should invoke. Must match the engine that owns the resource — for index suggestions: databases (legacy), tablesDB, documentsDB, or vectorsDB.
  final String service;

  /// Public API method on the chosen service the client should invoke when this CTA is triggered.
  final String method;

  /// Parameter map the client should pass to the service method when this CTA is triggered. Keys match the target API&#039;s parameter names (e.g. databaseId/tableId/columns for tablesDB, databaseId/collectionId/attributes for the legacy Databases API).
  final Map<String, dynamic> params;

  InsightCTA({
    required this.label,
    required this.service,
    required this.method,
    required this.params,
  });

  factory InsightCTA.fromMap(Map<String, dynamic> map) {
    return InsightCTA(
      label: map['label'].toString(),
      service: map['service'].toString(),
      method: map['method'].toString(),
      params: map['params'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "label": label,
      "service": service,
      "method": method,
      "params": params,
    };
  }
}
