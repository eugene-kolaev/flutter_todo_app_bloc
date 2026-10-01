part of 'note_bloc.dart';

class NoteState extends Equatable{

  const NoteState({
    this.notes = const [],
    this.isLoading = false,
    this.isLoaded = false,
    this.error,
    this.lastCreatedId,
  });

  final List<Note> notes;
  final bool isLoading;
  final bool isLoaded;
  final String? error;
  final String? lastCreatedId;

  bool get isEmpty => isLoaded && notes.isEmpty && error == null;
  bool get hasError => error != null;

  NoteState copyWith({
    List<Note>? notes,
    bool? isLoading,
    bool? isLoaded,
    String? error,
    bool clearError = false,
    String? lastCreatedId,
    bool clearLastCreatedId = false,
}) {
    return NoteState(
      notes: notes ?? this.notes,
      isLoading: isLoading ?? this.isLoading,
      isLoaded: isLoaded ?? this.isLoaded,
      error: clearError ? null : (error ?? this.error),
      lastCreatedId: clearLastCreatedId
          ? null
          : (lastCreatedId ?? this.lastCreatedId),
    );
  }

  @override
  List<Object?> get props => [
    notes.length,
    ...notes,
    isLoading,
    isLoaded,
    error,
    lastCreatedId,
  ];

}