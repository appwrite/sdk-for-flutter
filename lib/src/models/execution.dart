part of appwrite.models;

/// Execution
class Execution implements Model {
    /// Execution ID.
    final String $id;
    /// Execution creation date in Datetime
    final String $createdAt;
    /// Execution upate date in Datetime
    final String $updatedAt;
    /// Execution roles.
    final List $permissions;
    /// Function ID.
    final String functionId;
    /// The trigger that caused the function to execute. Possible values can be: `http`, `schedule`, or `event`.
    final String trigger;
    /// The status of the function execution. Possible values can be: `waiting`, `processing`, `completed`, or `failed`.
    final String status;
    /// The script status code.
    final int statusCode;
    /// The script response output string. Logs the last 4,000 characters of the execution response output.
    final String response;
    /// The script stdout output string. Logs the last 4,000 characters of the execution stdout output. This will return an empty string unless the response is returned using an API key or as part of a webhook payload.
    final String stdout;
    /// The script stderr output string. Logs the last 4,000 characters of the execution stderr output. This will return an empty string unless the response is returned using an API key or as part of a webhook payload.
    final String stderr;
    /// The script execution time in seconds.
    final double time;

    Execution({        required this.$id,
        required this.$createdAt,
        required this.$updatedAt,
        required this.$permissions,
        required this.functionId,
        required this.trigger,
        required this.status,
        required this.statusCode,
        required this.response,
        required this.stdout,
        required this.stderr,
        required this.time,
    });

    factory Execution.fromMap(Map<String, dynamic> map) {
        return Execution(
            $id: map['\$id'].toString(),
            $createdAt: map['\$createdAt'].toString(),
            $updatedAt: map['\$updatedAt'].toString(),
            $permissions: map['\$permissions'],
            functionId: map['functionId'].toString(),
            trigger: map['trigger'].toString(),
            status: map['status'].toString(),
            statusCode: map['statusCode'],
            response: map['response'].toString(),
            stdout: map['stdout'].toString(),
            stderr: map['stderr'].toString(),
            time: map['time'].toDouble(),
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
            "statusCode": statusCode,
            "response": response,
            "stdout": stdout,
            "stderr": stderr,
            "time": time,
        };
    }
}
