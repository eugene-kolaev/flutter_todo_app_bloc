

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../features/auth/presentation/bloc/auth_bloc.dart';
import 'app_router.dart';

@injectable
class SplashGuard extends AutoRouteGuard {
  final AuthBloc _authBloc;
  SplashGuard(this._authBloc);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final state = _authBloc.state;
    debugPrint('SplashGuard: isInitialized=${state.isInitialized}, user=${state.user?.uid}');
    if (!state.isInitialized) {
      resolver.next(true);
      return;
    }

    if (state.isAuthenticated) {
      router.replaceAll([const NotesRoute()]);
    } else {
      router.replaceAll([const LoginRoute()]);
    }
  }
}