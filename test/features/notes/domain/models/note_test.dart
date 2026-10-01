import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_app/features/notes/domain/models/note.dart';

void main() {
  group('Note', () {
    // ---- Конструктор ----

    test('создаётся с обязательными полями', () {
      final note = Note(
        id: '1',
        text: 'Привет',
        date: DateTime(2025, 5, 15),
      );

      expect(note.id, '1');
      expect(note.text, 'Привет');
      expect(note.date, DateTime(2025, 5, 15));
    });

    // ---- copyWith ----

    test('copyWith меняет только указанное поле', () {
      final note = Note(
        id: '1',
        text: 'a',
        date: DateTime(2025),
      );

      final updated = note.copyWith(text: 'b');

      expect(updated.id, '1');           // не изменился
      expect(updated.text, 'b');         // изменился
      expect(updated.date, note.date);   // не изменился
    });

    test('copyWith без аргументов возвращает эквивалентный объект', () {
      final note = Note(id: '1', text: 'a', date: DateTime(2025));
      final copy = note.copyWith();

      expect(copy, note);
    });

    test('copyWith меняет все поля', () {
      final note = Note(id: '1', text: 'a', date: DateTime(2025));

      final updated = note.copyWith(
        id: '2',
        text: 'b',
        date: DateTime(2026),
      );

      expect(updated.id, '2');
      expect(updated.text, 'b');
      expect(updated.date, DateTime(2026));
    });

    // ---- == и hashCode ----

    test('два Note с одинаковыми полями равны', () {
      final a = Note(id: '1', text: 'a', date: DateTime(2025));
      final b = Note(id: '1', text: 'a', date: DateTime(2025));

      expect(a, b);
      expect(a.hashCode, b.hashCode);
    });

    test('два Note с разными id не равны', () {
      final a = Note(id: '1', text: 'a', date: DateTime(2025));
      final b = Note(id: '2', text: 'a', date: DateTime(2025));

      expect(a, isNot(b));
    });

    test('два Note с разным text не равны', () {
      final a = Note(id: '1', text: 'a', date: DateTime(2025));
      final b = Note(id: '1', text: 'b', date: DateTime(2025));

      expect(a, isNot(b));
    });

    test('два Note с разной date не равны', () {
      final a = Note(id: '1', text: 'a', date: DateTime(2025));
      final b = Note(id: '1', text: 'a', date: DateTime(2026));

      expect(a, isNot(b));
    });

    // ---- toString (опционально) ----

    test('toString содержит id и text', () {
      final note = Note(id: '1', text: 'Привет', date: DateTime(2025));
      final s = note.toString();

      expect(s, contains('1'));
      expect(s, contains('Привет'));
    });
  });
}