part of appwrite;

class Query {
  static equal(String attribute, dynamic value) =>
      _addQuery(attribute, 'equal', value);

  static notEqual(String attribute, dynamic value) =>
      _addQuery(attribute, 'notEqual', value);

  static lesser(String attribute, dynamic value) =>
      _addQuery(attribute, 'lesser', value);

  static lesserEqual(String attribute, dynamic value) =>
      _addQuery(attribute, 'lesserEqual', value);

  static greater(String attribute, dynamic value) =>
      _addQuery(attribute, 'greater', value);

  static greaterEqual(String attribute, dynamic value) =>
      _addQuery(attribute, 'greaterEqual', value);

  static search(String attribute, String value) =>
      _addQuery(attribute, 'search', value);

  static String _addQuery(String attribute, String oper, dynamic value) => (value
          is List)
      ? '$attribute.$oper(${value.map((item) => parseValues(item)).join(",")})'
      : '$attribute.$oper(${parseValues(value)})';

  static String parseValues(dynamic value) =>
      (value is String) ? '"$value"' : '$value';
}
