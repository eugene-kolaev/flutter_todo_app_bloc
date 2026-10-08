import 'package:auto_route/auto_route.dart';
import 'package:flutter_todo_app/core/router/app_router.dart';
import 'package:flutter_todo_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:injectable/injectable.dart';


@injectable
class AuthGuard extends AutoRouteGuard {
  final AuthBloc _authBloc;
  AuthGuard(this._authBloc);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final state = _authBloc.state;

    if (state.isAuthenticated) {
      resolver.next(true);
    } else {
      router.replaceAll([const LoginRoute()]);
    }
  }
}