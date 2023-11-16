part of appwrite.enums;

enum Method {
    gET(value: 'GET'),
    pOST(value: 'POST'),
    pUT(value: 'PUT'),
    pATCH(value: 'PATCH'),
    dELETE(value: 'DELETE'),
    oPTIONS(value: 'OPTIONS');

    const Method({
        required this.value
    });

    final String value;

    String toJson() => value;
}