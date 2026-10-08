import 'package:injectable/injectable.dart';

import '../models/note.dart';
import '../repository/notes_repository.dart';

@lazySingleton
class UpdateNote {
  final NotesRepository _repository;

  UpdateNote(this._repository);

  // Future<Note> call({required String id, required String text}) async {
  //   final all = await _repository.getAll();
  //   final current = all.firstWhere(
  //         (n) => n.id == id,
  //     orElse: () => throw StateError('Заметка $id не найдена'),
  //   );
  //
  //   final updated = current.copyWith(text: text);
  //   await _repository.save(updated);
  //   return updated;
  // }

Future<void> call(Note note) => _repository.save(note);
}