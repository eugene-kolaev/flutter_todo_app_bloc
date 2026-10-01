import 'package:injectable/injectable.dart';

import '../models/note.dart';
import '../repository/notes_repository.dart';

@Injectable()
class GetAllNotes {
  final NotesRepository _repository;

  GetAllNotes(this._repository);

  Future<List<Note>> call() => _repository.getAll();
}