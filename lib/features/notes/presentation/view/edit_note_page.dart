import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../domain/models/note.dart';
import '../bloc/note_bloc.dart';


@RoutePage()
class EditNotePage extends StatelessWidget {
  final String id;

  const EditNotePage({super.key, @PathParam('id') required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        final note = _findNote(state, id);

        if (note == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return _EditNoteView(note: note);
      },
    );
  }

  static Note? _findNote(NoteState state, String id) {
    for (final n in state.notes) {
      if (n.id == id) return n;
    }
    return null;
  }
}

class _EditNoteView extends StatefulWidget {
  final Note note;
  const _EditNoteView({required this.note});

  @override
  State<_EditNoteView> createState() => _EditNoteViewState();
}

class _EditNoteViewState extends State<_EditNoteView> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.note.text);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bg = const Color.fromRGBO(220, 220, 220, 1);
    final formattedDate = DateFormat('dd.MM.yyyy').format(widget.note.date);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        centerTitle: true,
        title: Text("Editing",
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 82),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: const BorderRadius.all(Radius.circular(8))),
            child: TextFormField(
                controller: _controller,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Enter a note',
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                ),
              ),
          ),
            SizedBox(height: 10,),
            Text(formattedDate, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12))
    ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onSave(context),
        tooltip: 'save',
        backgroundColor: Colors.grey.shade700,
        shape: const CircleBorder(),
        child: const Icon(Icons.save, color: Colors.white),
      ),
    );
  }

  Future<void> _onSave(BuildContext context) async {
    context.read<NoteBloc>().add(NoteUpdate(id: widget.note.id, text: _controller.text));
    context.router.pop();
  }
}