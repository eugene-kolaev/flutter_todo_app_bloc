import 'package:injectable/injectable.dart';

import '../models/note.dart';
import '../repository/notes_repository.dart';

@lazySingleton
class GetAllNotes {
  final NotesRepository _repository;

  GetAllNotes(this._repository);

  Future<List<Note>> call(String userId) => _repository.getAll(userId);
}