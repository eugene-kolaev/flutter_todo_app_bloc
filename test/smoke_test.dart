import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_app/features/notes/domain/repository/notes_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_todo_app/features/notes/domain/models/note.dart';

import 'helpers/mocks.mocks.dart';

void main() {
  test('mock stub works', () async {
    final mock = MockNotesRepository();
    expect(mock, isA<NotesRepository>());

    print('runtimeType: ${mock.runtimeType}');
    print('is Mock: ${mock is Mock}');
    print('is NotesRepository: ${mock is NotesRepository}');

    when(mock.getAll()).thenAnswer((_) async => <Note>[]);

    final result = await mock.getAll();
    expect(result, isEmpty);
  });
}