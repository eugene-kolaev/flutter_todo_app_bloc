import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/router/app_router.dart';
import 'features/notes/domain/repository/notes_repository.dart';
import 'features/notes/presentation/bloc/note_cubit.dart';

class App extends StatelessWidget {
  final NotesRepository repository;
  const App({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NotesCubit(repository)..load(),
      child: MaterialApp.router(
        title: 'Diary app',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
        routerConfig: appRouter,
      ),
    );
  }
}