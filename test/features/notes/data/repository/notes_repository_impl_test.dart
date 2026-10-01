import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_app/core/database/notes_table.dart';
import 'package:flutter_todo_app/features/notes/data/repository/notes_repository_impl.dart';
import 'package:flutter_todo_app/features/notes/domain/models/note.dart';
import 'package:sqflite_common_ffi/sqflite_common_ffi.dart';

void main() {
  late Database db;
  late NotesRepositoryImpl repo;

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    db = await databaseFactory.openDatabase(
      inMemoryDatabasePath,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: (db, _) => db.execute(NotesTable.createTable),
      ),
    );
    repo = NotesRepositoryImpl(db);
  });

  tearDown(() => db.close());

  test('save и getAll работают', () async {
    final note = Note(id: '1', text: 'A', date: DateTime(2025));
    await repo.save(note);

    final all = await repo.getAll();
    expect(all.length, 1);
    expect(all.first.text, 'A');
  });
}