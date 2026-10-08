import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/core/router/auth_router_notifier.dart';
import 'core/di/injector.dart';
import 'core/router/app_router.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/notes/presentation/bloc/note_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = getIt<AppRouter>();

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<AuthBloc>()..add(const AuthStarted())),
        BlocProvider(create: (_) => getIt<NoteBloc>()..add(const NoteLoad())),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listenWhen: (prev, curr) => prev.user?.uid != curr.user?.uid,
            listener: (context, state) {
              context.read<NoteBloc>().add(NoteUserIdChanged(state.user?.uid));
            },
          ),
          BlocListener<AuthBloc, AuthState>(
            listenWhen: (prev, curr) =>
            (!prev.isInitialized && curr.isInitialized) ||
                prev.user?.uid != curr.user?.uid,
            listener: (context, state) {
              if (!state.isInitialized) return;

              if (state.isAuthenticated) {
                appRouter.replaceAll([const NotesRoute()], updateExistingRoutes: false,);
              } else {
                appRouter.replaceAll([const LoginRoute()], updateExistingRoutes: false,);
              }
            },
          ),
        ],
        child: MaterialApp.router(
          title: 'Todo',
          theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
          routerConfig: appRouter.config(),
          builder: (context, child) {
            return BlocBuilder<AuthBloc, AuthState>(
              buildWhen: (prev, curr) => prev.isInitialized != curr.isInitialized,
              builder: (context, state) {
                if (!state.isInitialized) {
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                }
                return child ?? const SizedBox.shrink();
              },
            );
          },
        )
        ),
      );
  }
}
