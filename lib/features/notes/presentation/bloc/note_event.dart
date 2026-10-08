part of 'note_bloc.dart';

abstract class NoteEvent {
  const NoteEvent();
}

class NoteUserIdChanged extends NoteEvent {
  final String? userId;
  const NoteUserIdChanged(this.userId);
}

class NoteLoad extends NoteEvent {
  const NoteLoad();
}

class NoteCreate extends NoteEvent {
  const NoteCreate();
}

class NoteUpdate extends NoteEvent {
  final String id;
  final String text;

  const NoteUpdate({required this.id, required this.text});
}

class NoteDelete extends NoteEvent {
  final String id;

  const NoteDelete({required this.id});
}

class NoteResetCreated extends NoteEvent {
  const NoteResetCreated();
}

