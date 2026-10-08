import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/models/note.dart';
part 'note_model.freezed.dart';

@freezed
abstract class NoteModel with _$NoteModel {
  const NoteModel._();

  const factory NoteModel({
    required String id,
    required String userId,
    required String note,
    required String date,
  }) = _NoteModel;

  factory NoteModel.fromMap(Map<String, Object?> map) {
    return NoteModel(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      note: map['note'] as String,
      date: map['date'] as String,
    );
  }

  Map<String, Object?> toMap() {
    return{
      'id': id,
      'user_id': userId,
      'note': note,
      'date': date
    };
  }

  Note toEntity() {
    return Note(
      id: id,
      userId: userId,
      text: note,
      date: DateTime.parse(date),
    );
  }

  factory NoteModel.fromEntity(Note note) {
    return NoteModel(
      id: note.id,
      userId: note.userId,
      note: note.text,
      date: note.date.toIso8601String()
    );
  }
}
