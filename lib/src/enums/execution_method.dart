part of '../../enums.dart';

enum ExecutionMethod {
    get(value: 'GET'),
    post(value: 'POST'),
    put(value: 'PUT'),
    patch(value: 'PATCH'),
    delete(value: 'DELETE'),
    options(value: 'OPTIONS');

    const ExecutionMethod({
        required this.value
    });

    final String value;

    String toJson() => value;
}