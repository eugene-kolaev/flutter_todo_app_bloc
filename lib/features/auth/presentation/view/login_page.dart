import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/core/router/app_router.dart';
import 'package:flutter_todo_app/features/auth/presentation/widgets/auth_form.dart';
import 'package:flutter_todo_app/features/auth/presentation/widgets/auth_scaffold.dart';

import '../../../../core/di/injector.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/auth_reveal_transition.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _submitButtonKey = GlobalKey();
  bool _revealStarted = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (prev, curr) =>
      !prev.isAuthenticated && curr.isAuthenticated,
      listener: (context, state) {
        if (_revealStarted) return;
        _revealStarted = true;

        showAuthRevealTransition(
          context: context,
          buttonKey: _submitButtonKey,
          color: Theme.of(context).colorScheme.primary,
          onRevealComplete: () {
            getIt<AppRouter>().replaceAll([const NotesRoute()]);
          },
        );
      },
      child: AuthScaffold(
        title: 'Вход',
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return AuthForm(
              submitLabel: 'Войти',
              isLoading: state.isLoading,
              submitButtonKey: _submitButtonKey,
              onSubmit: (email, password) async {
                context.read<AuthBloc>().add(
                  AuthSignInRequested(
                    email: email,
                    password: password,
                  ),
                );
              },
            );
          },
        ),
        footer: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Нет аккаунта? '),
            TextButton(
              onPressed: () => context.router.push(const RegisterRoute()),
              child: const Text('Зарегистрироваться'),
            ),
          ],
        ),
      ),
    );
  }
}