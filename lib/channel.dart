part of appwrite;

// Marker classes for type safety
class _Root {}

class _Database {}

class _Collection {}

class _Document {}

class _TablesDB {}

class _Table {}

class _Row {}

class _Bucket {}

class _File {}

class _Func {}

class _Execution {}

class _Team {}

class _Membership {}

class _Resolved {}

// Helper function for normalizing ID
String _normalize(String id) => id.trim().isEmpty ? '*' : id.trim();

/// Channel class with generic type parameter for type-safe method chaining
class Channel<T> {
  final List<String> _segments;

  Channel._(this._segments);

  /// Internal helper to transition to next state with segment and optional ID
  Channel<N> _next<N>(String segment, [String? id]) {
    final segments = [..._segments, segment];

    if (id != null) {
      segments.add(_normalize(id));
    }

    return Channel<N>._(segments);
  }

  /// Internal helper for terminal actions (no ID segment)
  Channel<_Resolved> _resolve(String action) {
    return Channel<_Resolved>._([..._segments, action]);
  }

  @override
  String toString() => _segments.join('.');

  // --- ROOT FACTORIES ---
  static Channel<_Database> database([String id = '*']) =>
      Channel<_Database>._(['databases', _normalize(id)]);

  static Channel<_TablesDB> tablesdb([String id = '*']) =>
      Channel<_TablesDB>._(['tablesdb', _normalize(id)]);

  static Channel<_Bucket> bucket([String id = '*']) =>
      Channel<_Bucket>._(['buckets', _normalize(id)]);

  static Channel<_Execution> execution([String id = '*']) =>
      Channel<_Execution>._(['executions', _normalize(id)]);

  static Channel<_Func> function([String id = '*']) =>
      Channel<_Func>._(['functions', _normalize(id)]);

  static Channel<_Team> team([String id = '*']) =>
      Channel<_Team>._(['teams', _normalize(id)]);

  static Channel<_Membership> membership([String id = '*']) =>
      Channel<_Membership>._(['memberships', _normalize(id)]);

  static String account() => 'account';

  // Global events
  static String documents() => 'documents';
  static String rows() => 'rows';
  static String files() => 'files';
  static String executions() => 'executions';
  static String teams() => 'teams';
  static String memberships() => 'memberships';
}

// --- DATABASE ROUTE ---
// Extension methods restricted by receiver type

/// Only available on Channel<_Database>
extension DatabaseChannel on Channel<_Database> {
  Channel<_Collection> collection([String? id]) =>
      _next<_Collection>('collections', id ?? '*');
}

/// Only available on Channel<_Collection>
extension CollectionChannel on Channel<_Collection> {
  Channel<_Document> document([String? id]) =>
      _next<_Document>('documents', id);
}

// --- TABLESDB ROUTE ---

/// Only available on Channel<_TablesDB>
extension TablesDBChannel on Channel<_TablesDB> {
  Channel<_Table> table([String? id]) => _next<_Table>('tables', id ?? '*');
}

/// Only available on Channel<_Table>
extension TableChannel on Channel<_Table> {
  Channel<_Row> row([String? id]) => _next<_Row>('rows', id);
}

// --- BUCKET ROUTE ---

/// Only available on Channel<_Bucket>
extension BucketChannel on Channel<_Bucket> {
  Channel<_File> file([String? id]) => _next<_File>('files', id);
}

// --- TERMINAL ACTIONS ---
// Restricted to actionable types (_Document, _Row, _File, _Execution, _Team, _Membership)

/// Only available on Channel<_Document>
extension DocumentChannel on Channel<_Document> {
  Channel<_Resolved> create() => _resolve('create');
  Channel<_Resolved> update() => _resolve('update');
  Channel<_Resolved> delete() => _resolve('delete');
}

/// Only available on Channel<_Row>
extension RowChannel on Channel<_Row> {
  Channel<_Resolved> create() => _resolve('create');
  Channel<_Resolved> update() => _resolve('update');
  Channel<_Resolved> delete() => _resolve('delete');
}

/// Only available on Channel<_File>
extension FileChannel on Channel<_File> {
  Channel<_Resolved> create() => _resolve('create');
  Channel<_Resolved> update() => _resolve('update');
  Channel<_Resolved> delete() => _resolve('delete');
}

/// Only available on Channel<_Team>
extension TeamChannel on Channel<_Team> {
  Channel<_Resolved> create() => _resolve('create');
  Channel<_Resolved> update() => _resolve('update');
  Channel<_Resolved> delete() => _resolve('delete');
}

/// Only available on Channel<_Membership>
extension MembershipChannel on Channel<_Membership> {
  Channel<_Resolved> create() => _resolve('create');
  Channel<_Resolved> update() => _resolve('update');
  Channel<_Resolved> delete() => _resolve('delete');
}
