import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';

import '../../features/auth/presentation/bloc/auth_bloc.dart';
import 'app_router.dart';

@injectable
class GuestGuard extends AutoRouteGuard {
  final AuthBloc _authBloc;
  GuestGuard(this._authBloc);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final state = _authBloc.state;

    if (state.isAuthenticated) {
      router.replaceAll([const NotesRoute()]);
    } else {
      resolver.next(true);
    }
  }
}