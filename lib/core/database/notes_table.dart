class NotesTable {
  static const table = 'notes';

  static const createTable = '''
    CREATE TABLE notes(
      id TEXT PRIMARY KEY,
      user_id TEXT NOT NULL,
      note TEXT,
      date TEXT
    )
  ''';

  static const createUserIndex = '''
    CREATE INDEX idx_notes_user_id ON notes(user_id)
  ''';
}

