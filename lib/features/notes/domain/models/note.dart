import 'package:freezed_annotation/freezed_annotation.dart';
part 'note.freezed.dart';

@freezed
abstract class Note with _$Note {
  const Note._();
  const factory Note({
    required String id,
    required String text,
    required DateTime date,
  }) = _Note;

  bool get isEmpty => text.trim().isEmpty;
}



// class Note {
//   final String id;
//   final String text;
//   final DateTime date;
//
//   const Note({
//     required this.id,
//     required this.text,
//     required this.date,
//   });
//
//   String? validateText() {
//     if (text
//         .trim()
//         .isEmpty) {
//       return 'Please enter a note';
//     }
//     return null;
//   }
//
//   bool get isValid => validateText() == null;
//
//   Note copyWith({
//     String? id,
//     String? text,
//     DateTime? date,
//   }) {
//     return Note(
//       id: id ?? this.id,
//       text: text ?? this.text,
//       date: date ?? this.date,
//     );
//   }
//
//   @override
//   String toString() => 'Note{id: $id, text: $text, date: $date}';
//
// }