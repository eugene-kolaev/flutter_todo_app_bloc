import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/models/user.dart';
import '../../domain/use_cases/auth_state_changes.dart';
import '../../domain/use_cases/sign_in.dart';
import '../../domain/use_cases/sign_out.dart';
import '../../domain/use_cases/sign_up.dart';


part 'auth_event.dart';
part 'auth_state.dart';

@lazySingleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignIn _signIn;
  final SignUp _signUp;
  final SignOut _signOut;
  final AuthStateChanges _authStateChanges;

  AuthBloc({
    required SignIn signIn,
    required SignUp signUp,
    required SignOut signOut,
    required AuthStateChanges authStateChanges,
  }) : _signIn = signIn,
       _signUp = signUp,
       _signOut = signOut,
       _authStateChanges = authStateChanges,
       super(const AuthState()) {
    on<AuthStarted>(_onStarted);
    on<AuthSignInRequested>(_onSignIn);
    on<AuthSignUpRequested>(_onSignUp);
    on<AuthSignOutRequested>(_onSignOut);
  }


  Future<void> _onStarted(AuthStarted event, Emitter<AuthState> emit) async {
    debugPrint('AuthBloc: _onStarted подписался на стрим');
    await emit.forEach<User?>(
      _authStateChanges(),
      onData: (user) {
        debugPrint('AuthBloc: onData user=${user?.uid}, isInitialized=true');
        return AuthState(
        user: user,
        isInitialized: true,
        isLoading: false,
        error: null,
      );
        },
      onError: (error, _) {
        debugPrint('AuthBloc: onError $error');
        return AuthState(
          isInitialized: true,
          error: error.toString(),
        );
      },
    );
  }

  Future<void> _onSignIn(
      AuthSignInRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      await _signIn(email: event.email, password: event.password);
      emit(state.copyWith(isLoading: false));
    }catch (e){
      emit(state.copyWith(isLoading: false, error: "Не удалось войти: $e"));
    }
  }

  Future<void> _onSignUp(
      AuthSignUpRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit (state.copyWith(isLoading: true, clearError: true));
    try {
      await _signUp(email: event.email, password: event.password);
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: 'Не удалось зарегистрироваться: $e',
      ));
    }
  }

  Future<void> _onSignOut(
      AuthSignOutRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(state.copyWith(isLoading: true, clearError: true));

    try {
      await _signOut();
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: 'Не удалось выйти $e',
      ));
    }
  }

}
