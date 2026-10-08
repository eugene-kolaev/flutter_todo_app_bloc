import '../models/note.dart';

abstract class NotesRepository {
  Future<List<Note>> getAll(String userId);
  Future<void> save(Note note);
  Future<void> delete(String id);
  Future<void> deleteAll(String userId);
}