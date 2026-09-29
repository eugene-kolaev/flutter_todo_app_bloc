import 'package:go_router/go_router.dart';

import '../../features/notes/presentation/view/edit_note_page.dart';
import '../../features/notes/presentation/view/notes_page.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'notes',
      builder: (context, state) => const NotesPage(),
      routes: [
        GoRoute(
          path: 'edit/:id',
          name: 'editNote',
          builder: (context, state) => EditNotePage(
            id: state.pathParameters['id']!,
          ),
        ),
      ],
    ),
  ],
);