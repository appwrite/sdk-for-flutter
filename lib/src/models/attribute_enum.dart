part of appwrite.models;

/// AttributeEnum
class AttributeEnum implements Model {
    /// Attribute Key.
    final String key;
    /// Attribute type.
    final String type;
    /// Attribute status. Possible values: `available`, `processing`, `deleting`, `stuck`, or `failed`
    final String status;
    /// Is attribute required?
    final bool xrequired;
    /// Is attribute an array?
    final bool? array;
    /// Array of elements in enumerated type.
    final List elements;
    /// String format.
    final String format;
    /// Default value for attribute when not provided. Cannot be set when attribute is required.
    final String? xdefault;

    AttributeEnum({
        required this.key,
        required this.type,
        required this.status,
        required this.xrequired,
this.array,
        required this.elements,
        required this.format,
this.xdefault,
    });

    factory AttributeEnum.fromMap(Map<String, dynamic> map) {
        return AttributeEnum(
            key: map['key'].toString(),
            type: map['type'].toString(),
            status: map['status'].toString(),
            xrequired: map['required'],
            array: map['array'],
            elements: map['elements'],
            format: map['format'].toString(),
            xdefault: map['default']?.toString(),
        );
    }

    @override
    Map<String, dynamic> toMap() {
        return {
            "key": key,
            "type": type,
            "status": status,
            "required": xrequired,
            "array": array,
            "elements": elements,
            "format": format,
            "default": xdefault,
        };
    }
}
