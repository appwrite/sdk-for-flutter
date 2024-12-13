part of '../../enums.dart';

enum ExecutionMethod {
    gET(value: 'GET'),
    pOST(value: 'POST'),
    pUT(value: 'PUT'),
    pATCH(value: 'PATCH'),
    dELETE(value: 'DELETE'),
    oPTIONS(value: 'OPTIONS');

    const ExecutionMethod({
        required this.value
    });

    final String value;

    String toJson() => value;
}