import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/core/router/app_router.dart';
import 'package:flutter_todo_app/features/auth/presentation/widgets/auth_form.dart';
import 'package:flutter_todo_app/features/auth/presentation/widgets/auth_scaffold.dart';

import '../bloc/auth_bloc.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (prev, curr) => curr.hasError && prev.error != curr.error,
      listener: (context, state) {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
            SnackBar(
              content: Text(state.error!),
              backgroundColor: Colors.red.shade700,
              behavior: SnackBarBehavior.floating,
            ),
          );
      },
      child: AuthScaffold(
        title: 'Вход',
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return AuthForm(
              submitLabel: 'Войти',
              isLoading: state.isLoading,
              onSubmit: (email, password) async {
                context.read<AuthBloc>().add(
                  AuthSignInRequested(email: email, password: password),
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
