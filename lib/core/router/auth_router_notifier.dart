
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../features/auth/presentation/bloc/auth_bloc.dart';

@lazySingleton
class AuthRouterNotifier extends ChangeNotifier{
  AuthRouterNotifier(AuthBloc authBloc) {
    debugPrint('AuthRouterNotifier: подписался');
    _subscription = authBloc.stream.listen((state) {
      debugPrint('AuthRouterNotifier: notifyListeners, user=${state.user?.uid}, init=${state.isInitialized}');
      notifyListeners();
    });
  }

  late final StreamSubscription _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}