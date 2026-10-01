import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../core/database/notes_table.dart';
import '../../domain/models/note.dart';
import '../dto/note_model.dart';
import '../../domain/repository/notes_repository.dart';

@LazySingleton(as: NotesRepository)
class NotesRepositoryImpl implements NotesRepository {
  final Database db;

  NotesRepositoryImpl(this.db);

  @override
  Future<List<Note>> getAll() async {
    final rows = await db.query(NotesTable.table, orderBy: 'date DESC');
    return rows.map((row) => NoteModel.fromMap(row).toEntity()).toList();
  }

  @override
  Future<void> save(Note note) async {
    final model = NoteModel.fromEntity(note);
    await db.insert(
      NotesTable.table,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> delete(String id) async {
    await db.delete(
      NotesTable.table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> deleteAll() async {
    await db.delete(NotesTable.table);
  }
}