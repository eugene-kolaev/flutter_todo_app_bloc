import '../../data/entities/note.dart';

abstract class NotesRepository {
  Future<List<Note>> getAll();
  Future<void> save(Note note);
  Future<void> delete(String id);
  Future<void> deleteAll();
}