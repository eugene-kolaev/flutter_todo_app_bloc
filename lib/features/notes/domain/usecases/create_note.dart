import 'package:injectable/injectable.dart';

import '../models/note.dart';
import '../repository/notes_repository.dart';
import 'package:uuid/uuid.dart';

@Injectable()
class CreateNote {
  final NotesRepository _repository;
  final _uuid = const Uuid();


  CreateNote(this._repository);

  Future<Note> call() async {
    final note = Note(
      id: _uuid.v4(),
      text: '',
      date: DateTime.now(),
    );
    await _repository.save(note);
    return note;
  }
}