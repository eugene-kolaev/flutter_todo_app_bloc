import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';


import '../../domain/models/note.dart';
import '../../domain/repository/notes_repository.dart';
import 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  final NotesRepository _repository;
  final _uuid = const Uuid();

  NotesCubit(this._repository) : super(const NotesState.initial());

  /// Загрузить все заметки из БД
  Future<void> load() async {
    emit(const NotesState.loading());
    try {
      final notes = await _repository.getAll();
      if (notes.isEmpty) {
        emit(const NotesState.empty());
      } else {
        emit(NotesState.loaded(notes));
      }
    } catch (e) {
      emit(NotesState.error('Не удалось загрузить заметки: $e'));
    }
  }

  /// Создать пустую заметку и вернуть её id.
  /// Вызывается из FAB: пользователь сразу уходит в редактор.
  Future<String> create() async {
    final note = Note(
      id: _uuid.v4(),
      text: '',
      date: DateTime.now(),
    );
    await _repository.save(note);
    await load();
    return note.id;
  }

  /// Обновить текст заметки (вызывается из редактора)
  Future<void> updateText(String id, String newText) async {
    final current = state;
    if (current is! NotesLoaded) return;

    final updated = current.notes.map((n) {
      if (n.id == id) return n.copyWith(text: newText);
      return n;
    }).toList();
    emit(NotesState.loaded(updated));

    // Сохраняем в БД
    try {
      final note = updated.firstWhere((n) => n.id == id);
      await _repository.save(note);
    } catch (e) {
      emit(NotesState.error('Не удалось сохранить заметку: $e'));
      await load(); // откатываемся к состоянию из БД
    }
  }

  /// Удалить заметку
  Future<void> delete(String id) async {
    final current = state;
    if (current is! NotesLoaded) return;
    final updated = current.notes.where((n) => n.id != id).toList();
    if (updated.isEmpty) {
      emit(const NotesState.empty());
    } else {
      emit(NotesState.loaded(updated));
    }

    try {
      await _repository.delete(id);
    } catch (e) {
      emit(NotesState.error('Не удалось удалить заметку: $e'));
      await load(); // откатываемся
    }
  }
}