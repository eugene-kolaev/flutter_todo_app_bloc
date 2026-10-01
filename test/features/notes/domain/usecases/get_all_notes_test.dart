import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_app/features/notes/domain/models/note.dart';
import 'package:flutter_todo_app/features/notes/domain/usecases/get_all_notes.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/mocks.mocks.dart';

void main() {
  late MockNotesRepository mockRepo;

  setUp(() {
    mockRepo = MockNotesRepository();
  });

  test('возвращает список из репозитория', () async {
    when(() => mockRepo.getAll()).thenAnswer(
          (invocation) => () async => [
        Note(id: '1', text: 'A', date: DateTime(2025)),
        Note(id: '2', text: 'B', date: DateTime(2025)),
      ],
    );

    final useCase = GetAllNotes(mockRepo);
    final notes = await useCase();

    expect(notes.length, 2);
    expect(notes.first.text, 'A');
    verify(() => mockRepo.getAll()).called(1);
  });

  test('пробрасывает исключение из репозитория', () async {
    when(() => mockRepo.getAll()).thenThrow(Exception('DB error'));

    final useCase = GetAllNotes(mockRepo);

    expect(useCase, throwsA(isA<Exception>()));
  });
}