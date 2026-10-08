import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_todo_app/features/auth/presentation/widgets/auth_form.dart';
import 'package:flutter_todo_app/features/auth/presentation/widgets/auth_scaffold.dart';


@RoutePage()
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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
        title: 'Регистрация',
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return AuthForm(
              submitLabel: 'Создать аккаунт',
              isLoading: state.isLoading,
              onSubmit: ((email, password) async {
                context.read<AuthBloc>().add(
                  AuthSignUpRequested(email: email, password: password),
                );
              }),
            );
          },
        ),
        footer: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Уже есть аккаунт?"),
            TextButton(
              onPressed: () => context.router.pop(),
              child: const Text("Войти"),
            ),
          ],
        ),
      ),
    );
  }
}
