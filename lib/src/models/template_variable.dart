part of '../../models.dart';

/// Template Variable
class TemplateVariable implements Model {
  /// Variable Name.
  final String name;

  /// Variable Description.
  final String description;

  /// Variable Value.
  final String value;

  /// Variable Placeholder.
  final String placeholder;

  /// Is the variable required?
  final bool xrequired;

  /// Variable Type.
  final String type;

  TemplateVariable({
    required this.name,
    required this.description,
    required this.value,
    required this.placeholder,
    required this.xrequired,
    required this.type,
  });

  factory TemplateVariable.fromMap(Map<String, dynamic> map) {
    return TemplateVariable(
      name: map['name'].toString(),
      description: map['description'].toString(),
      value: map['value'].toString(),
      placeholder: map['placeholder'].toString(),
      xrequired: map['required'],
      type: map['type'].toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "description": description,
      "value": value,
      "placeholder": placeholder,
      "required": xrequired,
      "type": type,
    };
  }
}
