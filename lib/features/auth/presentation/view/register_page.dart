import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_todo_app/features/auth/presentation/widgets/auth_form.dart';
import 'package:flutter_todo_app/features/auth/presentation/widgets/auth_reveal_transition.dart';
import 'package:flutter_todo_app/features/auth/presentation/widgets/auth_scaffold.dart';

import '../../../../core/di/injector.dart';
import '../../../../core/router/app_router.dart';


@RoutePage()
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
        title: 'Регистрация',
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return AuthForm(
              submitLabel: 'Создать аккаунт',
              isLoading: state.isLoading,
              submitButtonKey: _submitButtonKey,
              onSubmit: (email, password) async {
                context.read<AuthBloc>().add(
                  AuthSignUpRequested(
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
            const Text('Уже есть аккаунт? '),
            TextButton(
              onPressed: () => context.router.pop(),
              child: const Text('Войти'),
            ),
          ],
        ),
      ),
    );
  }
}
