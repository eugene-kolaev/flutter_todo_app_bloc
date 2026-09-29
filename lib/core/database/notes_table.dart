class NotesTable {
  static const table = 'notes';

  static const createTable = '''
    CREATE TABLE notes(
      id TEXT PRIMARY KEY,
      note TEXT,
      date TEXT
    )
  ''';
}