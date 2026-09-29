

import '../../domain/models/note.dart';

class NoteModel {
  final String id;
  final String note;
  final String date;

  const NoteModel({
    required this.id,
    required this.note,
    required this.date,
  });

  factory NoteModel.fromMap(Map<String, Object?> map) {
    return NoteModel(
      id: map['id'] as String,
      note: map['note'] as String,
      date: map['date'] as String,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'note': note,
      'date': date,
    };
  }

  Note toEntity() {
    return Note(
      id: id,
      text: note,
      date: DateTime.parse(date),
    );
  }

  factory NoteModel.fromEntity(Note note) {
    return NoteModel(
      id: note.id,
      note: note.text,
      date: note.date.toIso8601String(),
    );
  }
}