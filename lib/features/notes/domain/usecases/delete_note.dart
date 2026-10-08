import 'package:injectable/injectable.dart';

import '../repository/notes_repository.dart';

@lazySingleton
class DeleteNote {
  final NotesRepository _repository;

  DeleteNote(this._repository);

  Future<void> call(String id) => _repository.delete(id);
}