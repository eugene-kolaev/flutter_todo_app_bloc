import 'dart:math';

import 'package:flutter_todo_app/features/notes/domain/models/note.dart';
import 'package:uuid/uuid.dart';

abstract class NoteFactory {
  Note random({
    String? id,
    String? text,
    DateTime? date,
  });
  List<Note> list({int count});
}

class NoteFactoryImpl implements NoteFactory {
  final Random _random;

  NoteFactoryImpl({Random? seed}) : _random = seed ?? Random();

  static const _text = [
    "Набросать схему идеального утра",
    "Список из 10 книг на этот год",
    "Придумать название для блога",
    "Записать 3 бизнес-идеи с нуля",
    "Что я хочу успеть до конца месяца",
    "Маршрут выходного дня в другом районе",
    "5 мест для отпуска",
    "План тренировок на неделю",
    "10 вещей, за которые я благодарен",
    "Цитата, которая зацепила сегодня",
    "Плейлист для поднятия настроения",
    "Письмо себе через 5 лет",
    "3 привычки для внедрения за 21 день",
    "Чек-лист дел перед сном",
    "Список навыков для освоения",
    "Рецепт идеального завтрака",
    "Записать пароль (в шифре)",
    "Размеры одежды близких",
    "Список фильмов от друзей",
    "Одним предложением: чем сегодня день особенный",
  ];

  @override
  Note random({
    String? id,
    String? text,
    DateTime? date,
}) {
    return Note(
      id: id ?? const Uuid().v4(),
      text: text ?? _text[_random.nextInt(_text.length)],
      date: date ?? DateTime(2025, 1, 1).add(Duration(days: _random.nextInt(365))),
    );
  }

  @override
  List<Note> list({int count = 10}) => List.generate(count, (_) => random());
}