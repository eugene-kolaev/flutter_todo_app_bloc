import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/injector.dart';
import 'core/router/app_router.dart';
import 'features/notes/presentation/bloc/note_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    final _appRouter = AppRouter();

    return BlocProvider(
      create: (_) => getIt<NoteBloc>()..add(const NoteLoad()),
      child: MaterialApp.router(
        title: 'Diary',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.indigo,
        ),
        routerConfig: _appRouter.config(),
      ),
    );
  }
}