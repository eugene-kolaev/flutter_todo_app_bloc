import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../../data/entities/note.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final VoidCallback onTap;
  final Future<void> Function() onDelete;

  const NoteCard({
    super.key,
    required this.note,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formatted = DateFormat('dd.MM.yyyy').format(note.date);

    return Slidable(
      key: ValueKey(note.id),
      endActionPane: ActionPane(
        extentRatio: 0.2,
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => onDelete(),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            backgroundColor: Colors.black.withValues(alpha: 0.4),
            icon: Icons.delete_forever,
            foregroundColor: Colors.red,
            label: 'Delete',
          ),
        ],
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.text.isEmpty ? '(Empty note)' : note.text,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 16),
              Container(
                color: const Color.fromRGBO(220, 220, 220, 1),
                width: double.infinity,
                height: 2,
              ),
              const SizedBox(height: 8),
              Text(
                formatted,
                style: const TextStyle(fontSize: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}