import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_app/features/notes/domain/models/note.dart';
import 'package:flutter_todo_app/features/notes/domain/usecases/create_note.dart';
import 'package:flutter_todo_app/features/notes/domain/usecases/delete_note.dart';
import 'package:flutter_todo_app/features/notes/domain/usecases/update_note.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_todo_app/features/notes/domain/usecases/get_all_notes.dart';
import 'package:flutter_todo_app/features/notes/presentation/bloc/note_bloc.dart';

import '../../../../helpers/mocks.mocks.dart';

void main() {
  late MockNotesRepository mockRepo;

  setUp(() => mockRepo = MockNotesRepository());

  blocTest<NoteBloc, NoteState>(
    'NoteLoad эмитит Loading → Loaded с заметками',
    build: () {
      when(() => mockRepo.getAll()).thenAnswer(
              (invocation) => () async => [
        Note(id: '1', text: 'A', date: DateTime(2025)),
      ]);
      return NoteBloc(
        getAllNotes: GetAllNotes(mockRepo),
        createNote: CreateNote(mockRepo),
        updateNote: UpdateNote(mockRepo),
        deleteNote: DeleteNote(mockRepo),
      );
    },
    act: (bloc) => bloc.add(const NoteLoad()),
    expect: () => [
      isA<NoteState>().having((s) => s.isLoading, 'isLoading', true),
      isA<NoteState>().having((s) => s.notes.length, 'notes.length', 1),
    ],
  );
}