part of '../../models.dart';

/// Function Templates List
class TemplateFunctionList implements Model {
  /// Total number of templates documents that matched your query.
  final int total;

  /// List of templates.
  final List<TemplateFunction> templates;

  TemplateFunctionList({
    required this.total,
    required this.templates,
  });

  factory TemplateFunctionList.fromMap(Map<String, dynamic> map) {
    return TemplateFunctionList(
      total: map['total'],
      templates: List<TemplateFunction>.from(
          map['templates'].map((p) => TemplateFunction.fromMap(p))),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "total": total,
      "templates": templates.map((p) => p.toMap()).toList(),
    };
  }
}
