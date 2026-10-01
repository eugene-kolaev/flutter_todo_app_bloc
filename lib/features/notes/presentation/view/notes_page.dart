import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/core/router/app_router.dart';
import 'package:flutter_todo_app/features/notes/presentation/bloc/note_bloc.dart';
import '../widgets/note_card.dart';

@RoutePage()
class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<NoteBloc, NoteState>(
      listenWhen: (previous, current) =>
      current.lastCreatedId != null &&
          previous.lastCreatedId != current.lastCreatedId,
      listener: (context, state) {
        context.router.push(EditNoteRoute(id: state.lastCreatedId!));
        context.read<NoteBloc>().add(const NoteResetCreated());
      },
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(220, 220, 220, 1),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(220, 220, 220, 1),
          centerTitle: true,
          title: const Text(
            'Notes',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 36),
          ),
        ),
        body: BlocBuilder<NoteBloc, NoteState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.hasError) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        state.error!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () =>
                            context.read<NoteBloc>().add(const NoteLoad()),
                        child: const Text("Повторить"),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state.isEmpty) {
              return const Center(child: Text('There are no notes yet'));
            }

            return ListView.builder(
              padding: EdgeInsets.only(bottom: 100),
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                final note = state.notes[index];
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    left: 16,
                    right: 16,
                    bottom: 16,
                  ),
                  child: NoteCard(
                    note: note,
                    onTap: () => context.router.push(EditNoteRoute(id: note.id)),
                    onDelete: () => _handleDelete(context, note.id),
                  ),
                );
              },
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: BlocBuilder<NoteBloc, NoteState>(
          builder: (context, state) {
            if (state.isLoading || !state.isLoaded) {
              return const SizedBox.shrink();
            }
            return FloatingActionButton(
              onPressed: () => _handleCreate(context),
              tooltip: 'add',
              backgroundColor: Colors.blueAccent,
              shape: const CircleBorder(),
              child: Icon(Icons.add, color: Colors.white),
            );
          },
        ),
    ),
    );
  }

  void _handleCreate(BuildContext context) {
    debugPrint('FAB Pressed');
    context.read<NoteBloc>().add(const NoteCreate());
  }

  Future<void> _handleDelete(BuildContext context, String id) async {
    context.read<NoteBloc>().add(NoteDelete(id: id));
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        const SnackBar(
          content: Text('Note deleted'),
          duration: Duration(seconds: 2),
        ),
      );
  }
}
