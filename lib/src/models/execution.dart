part of '../../models.dart';

/// Execution
class Execution implements Model {
    /// Execution ID.
    final String $id;
    /// Execution creation date in ISO 8601 format.
    final String $createdAt;
    /// Execution upate date in ISO 8601 format.
    final String $updatedAt;
    /// Execution roles.
    final List $permissions;
    /// Function ID.
    final String functionId;
    /// The trigger that caused the function to execute. Possible values can be: `http`, `schedule`, or `event`.
    final String trigger;
    /// The status of the function execution. Possible values can be: `waiting`, `processing`, `completed`, or `failed`.
    final String status;
    /// HTTP request method type.
    final String requestMethod;
    /// HTTP request path and query.
    final String requestPath;
    /// HTTP response headers as a key-value object. This will return only whitelisted headers. All headers are returned if execution is created as synchronous.
    final List<Headers> requestHeaders;
    /// HTTP response status code.
    final int responseStatusCode;
    /// HTTP response body. This will return empty unless execution is created as synchronous.
    final String responseBody;
    /// HTTP response headers as a key-value object. This will return only whitelisted headers. All headers are returned if execution is created as synchronous.
    final List<Headers> responseHeaders;
    /// Function logs. Includes the last 4,000 characters. This will return an empty string unless the response is returned using an API key or as part of a webhook payload.
    final String logs;
    /// Function errors. Includes the last 4,000 characters. This will return an empty string unless the response is returned using an API key or as part of a webhook payload.
    final String errors;
    /// Function execution duration in seconds.
    final double duration;
    /// The scheduled time for execution. If left empty, execution will be queued immediately.
    final String? scheduledAt;

    Execution({
        required this.$id,
        required this.$createdAt,
        required this.$updatedAt,
        required this.$permissions,
        required this.functionId,
        required this.trigger,
        required this.status,
        required this.requestMethod,
        required this.requestPath,
        required this.requestHeaders,
        required this.responseStatusCode,
        required this.responseBody,
        required this.responseHeaders,
        required this.logs,
        required this.errors,
        required this.duration,
        this.scheduledAt,
    });

    factory Execution.fromMap(Map<String, dynamic> map) {
        return Execution(
            $id: map['\$id'].toString(),
            $createdAt: map['\$createdAt'].toString(),
            $updatedAt: map['\$updatedAt'].toString(),
            $permissions: map['\$permissions'] ?? [],
            functionId: map['functionId'].toString(),
            trigger: map['trigger'].toString(),
            status: map['status'].toString(),
            requestMethod: map['requestMethod'].toString(),
            requestPath: map['requestPath'].toString(),
            requestHeaders: List<Headers>.from(map['requestHeaders'].map((p) => Headers.fromMap(p))),
            responseStatusCode: (map['responseStatusCode'] is String) ?
                        int.tryParse(map['responseStatusCode']) ?? 0:map['responseStatusCode'] ?? 0,
            responseBody: map['responseBody'].toString(),
            responseHeaders: List<Headers>.from(map['responseHeaders'].map((p) => Headers.fromMap(p))),
            logs: map['logs'].toString(),
            errors: map['errors'].toString(),
            duration: map['duration'].toDouble(),
            scheduledAt: map['scheduledAt']?.toString(),
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "\$id": $id,
            "\$createdAt": $createdAt,
            "\$updatedAt": $updatedAt,
            "\$permissions": $permissions,
            "functionId": functionId,
            "trigger": trigger,
            "status": status,
            "requestMethod": requestMethod,
            "requestPath": requestPath,
            "requestHeaders": requestHeaders.map((p) => p.toMap()).toList(),
            "responseStatusCode": responseStatusCode,
            "responseBody": responseBody,
            "responseHeaders": responseHeaders.map((p) => p.toMap()).toList(),
            "logs": logs,
            "errors": errors,
            "duration": duration,
            "scheduledAt": scheduledAt,
        };
    }
}
