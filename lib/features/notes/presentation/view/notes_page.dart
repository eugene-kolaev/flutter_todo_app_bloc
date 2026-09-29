import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/note_cubit.dart';
import '../bloc/notes_state.dart';
import '../widgets/note_card.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(220, 220, 220, 1),
        centerTitle: true,
        title: const Text(
          'Notes',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 36),
        ),
      ),
      body: Container(
        color: const Color.fromRGBO(220, 220, 220, 1),
        width: double.infinity,
        child: BlocBuilder<NotesCubit, NotesState>(
          builder: (context, state) {
            return switch (state) {
              NotesInitial() || NotesLoading() =>
              const Center(child: CircularProgressIndicator()),
              NotesError(:final message) =>
                  Center(child: Text(message)),
              NotesEmpty() =>
              const Center(child: Text('There are no notes yet')),
              NotesLoaded(:final notes) =>
                  ListView.builder(
                    padding: const EdgeInsets.only(bottom: 100),
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      final note = notes[index];
                      return Padding(
                        padding: const EdgeInsets.only(
                          top: 8, left: 16, right: 16, bottom: 16,
                        ),
                        child: NoteCard(
                          note: note,
                          onTap: () => context.push('/edit/${note.id}'),
                          onDelete: () => _handleDelete(context, note.id),
                        ),
                      );
                    },
                  ),
            };
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BlocBuilder<NotesCubit, NotesState>(
        builder: (context, state) {
          final isReady = state is NotesLoaded || state is NotesEmpty;
          if (!isReady) return const SizedBox.shrink();
          return FloatingActionButton(
            onPressed: () => _handleCreate(context),
            tooltip: 'add',
            backgroundColor: Colors.blue,
            shape: const CircleBorder(),
            child: const Icon(Icons.add, color: Colors.white),
          );
        },
      ),
    );
  }

  Future<void> _handleCreate(BuildContext context) async {
    final cubit = context.read<NotesCubit>();
    final id = await cubit.create();
    if (!context.mounted) return;
    context.push('/edit/$id');
  }

  Future<void> _handleDelete(BuildContext context, String id) async {
    final cubit = context.read<NotesCubit>();
    final messenger = ScaffoldMessenger.of(context);

    await cubit.delete(id);

    messenger
      ..clearSnackBars()
      ..showSnackBar(
        const SnackBar(content: Text('Note deleted'), duration: Duration(seconds: 2)),
      );
  }
}