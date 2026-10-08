import 'package:freezed_annotation/freezed_annotation.dart';
part 'note.freezed.dart';

@freezed
abstract class Note with _$Note {
  const Note._();
  const factory Note({
    required String id,
    required String userId,
    required String text,
    required DateTime date,
  }) = _Note;

  bool get isEmpty => text.trim().isEmpty;
}