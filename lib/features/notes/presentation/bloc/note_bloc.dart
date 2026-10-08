import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/features/notes/domain/usecases/create_note.dart';
import 'package:flutter_todo_app/features/notes/domain/usecases/delete_note.dart';
import 'package:flutter_todo_app/features/notes/domain/usecases/get_all_notes.dart';
import 'package:flutter_todo_app/features/notes/domain/usecases/update_note.dart';
import 'package:injectable/injectable.dart';

import '../../domain/models/note.dart';

part 'note_event.dart';

part 'note_state.dart';

@LazySingleton()
class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final GetAllNotes _getAllNotes;
  final CreateNote _createNote;
  final UpdateNote _updateNote;
  final DeleteNote _deleteNote;

  String? _currentUserId;

  NoteBloc({
    required GetAllNotes getAllNotes,
    required CreateNote createNote,
    required UpdateNote updateNote,
    required DeleteNote deleteNote,
  }) : _getAllNotes = getAllNotes,
       _createNote = createNote,
       _updateNote = updateNote,
       _deleteNote = deleteNote,
       super(const NoteState()) {
    on<NoteUserIdChanged>(_onUserIdChanged);
    on<NoteLoad>(_onLoad);
    on<NoteCreate>(_onCreate);
    on<NoteUpdate>(_onUpdate);
    on<NoteDelete>(_onDelete);
    on<NoteResetCreated>(_onResetCreated);
  }

  Future<void> _onUserIdChanged(NoteUserIdChanged event, Emitter<NoteState> emit) async {
_currentUserId = event.userId;
if(_currentUserId == null) {
  emit (const NoteState());
} else {
  add(const NoteLoad());
}
  }

  Future<void> _onLoad(NoteLoad event, Emitter<NoteState> emit) async {
    final userId = _currentUserId;
    if(userId == null) {
      emit(const NoteState());
      return;
    }

    emit(state.copyWith(isLoading: true, clearError: true));
    try{
      final notes = await _getAllNotes(userId);
      emit(state.copyWith(
        isLoading: false,
        isLoaded: true,
        notes: notes,
        clearError: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isLoaded: true,
        error: 'Не удалось загрузить заметки: $e',
      ));
    }
  }

  Future<void> _onCreate(NoteCreate event, Emitter<NoteState> emit) async {
    final userId = _currentUserId;
    if (userId == null) return;
    try {
      final note = await _createNote(userId: userId);
      final notes = await _getAllNotes(userId);

      emit(state.copyWith(
        notes: notes,
        isLoading: false,
        isLoaded: true,
        lastCreatedId: note.id,
        clearError: true,
      ));
    } catch (e) {
      debugPrint('_onCreate error: $e');
      emit(state.copyWith(isLoading: false, error: 'Не удалось создать заметку: $e'));
    }
  }

  Future<void> _onUpdate(NoteUpdate event, Emitter<NoteState> emit) async{
    final userId = _currentUserId;
    if(!state.isLoaded || _currentUserId == null) return;

    final index = state.notes.indexWhere((n) => n.id == event.id);
    if (index == 1) return;

    final current = state.notes[index];
    final updated = current.copyWith(text: event.text);

    final optimistic = [...state.notes];
    optimistic[index] = updated;
    emit(state.copyWith(notes: optimistic, clearError: true));

    try {
      await _updateNote(updated);
    } catch (e) {
      emit(state.copyWith(error: 'Не удалось сохранить заметку: $e'));
      final notes = await _getAllNotes(userId!);
      emit(state.copyWith(notes: notes, clearError: true));
      // await _reload(emit);
    }
  }

  Future<void> _onDelete(NoteDelete event, Emitter<NoteState> emit) async {
    final userId = _currentUserId;
    if (!state.isLoaded || _currentUserId == null) return;

    final optimisticDelete = state.notes.where((n) => n.id != event.id).toList();
    emit(state.copyWith(notes: optimisticDelete, clearError: true));

    try {
      await _deleteNote(event.id);
    } catch (e) {
      emit (state.copyWith(error: 'Не удалось удалить заметку: $e'));
      final notes = await _getAllNotes(userId!);
      emit(state.copyWith(notes: notes, clearError: true));
    }
  }

  Future<void> _onResetCreated(
      NoteResetCreated event,
      Emitter<NoteState> emit,
      ) async {
    emit(state.copyWith(clearLastCreatedId: true));
  }

  }

