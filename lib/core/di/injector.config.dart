// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:sqflite/sqflite.dart' as _i779;

import '../../features/auth/data/datasources/firebase_auth_datasource.dart'
    as _i393;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import '../../features/auth/domain/repository/auth_repository.dart' as _i961;
import '../../features/auth/domain/use_cases/auth_state_changes.dart' as _i323;
import '../../features/auth/domain/use_cases/sign_in.dart' as _i265;
import '../../features/auth/domain/use_cases/sign_out.dart' as _i420;
import '../../features/auth/domain/use_cases/sign_up.dart' as _i37;
import '../../features/auth/presentation/bloc/auth_bloc.dart' as _i797;
import '../../features/notes/data/repository/notes_repository_impl.dart'
    as _i467;
import '../../features/notes/domain/repository/notes_repository.dart' as _i505;
import '../../features/notes/domain/usecases/create_note.dart' as _i1060;
import '../../features/notes/domain/usecases/delete_note.dart' as _i567;
import '../../features/notes/domain/usecases/get_all_notes.dart' as _i522;
import '../../features/notes/domain/usecases/update_note.dart' as _i397;
import '../../features/notes/presentation/bloc/note_bloc.dart' as _i895;
import '../database/app_database.dart' as _i982;
import '../router/app_router.dart' as _i81;
import '../router/auth_guard.dart' as _i313;
import '../router/auth_router_notifier.dart' as _i1044;
import '../router/guest_guard.dart' as _i447;
import '../router/splash_guard.dart' as _i734;
import 'firebase_module.dart' as _i616;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appDatabase = _$AppDatabase();
    final firebaseModule = _$FirebaseModule();
    await gh.singletonAsync<_i779.Database>(
      () => appDatabase.database,
      preResolve: true,
    );
    gh.lazySingleton<_i59.FirebaseAuth>(() => firebaseModule.firebaseAuth);
    gh.lazySingleton<_i505.NotesRepository>(
      () => _i467.NotesRepositoryImpl(gh<_i779.Database>()),
    );
    gh.lazySingleton<_i393.FirebaseAuthDatasource>(
      () => _i393.FirebaseAuthDatasource(gh<_i59.FirebaseAuth>()),
    );
    gh.lazySingleton<_i1060.CreateNote>(
      () => _i1060.CreateNote(gh<_i505.NotesRepository>()),
    );
    gh.lazySingleton<_i567.DeleteNote>(
      () => _i567.DeleteNote(gh<_i505.NotesRepository>()),
    );
    gh.lazySingleton<_i522.GetAllNotes>(
      () => _i522.GetAllNotes(gh<_i505.NotesRepository>()),
    );
    gh.lazySingleton<_i397.UpdateNote>(
      () => _i397.UpdateNote(gh<_i505.NotesRepository>()),
    );
    gh.lazySingleton<_i961.AuthRepository>(
      () => _i153.AuthRepositoryImpl(gh<_i393.FirebaseAuthDatasource>()),
    );
    gh.lazySingleton<_i323.AuthStateChanges>(
      () => _i323.AuthStateChanges(gh<_i961.AuthRepository>()),
    );
    gh.lazySingleton<_i265.SignIn>(
      () => _i265.SignIn(gh<_i961.AuthRepository>()),
    );
    gh.lazySingleton<_i420.SignOut>(
      () => _i420.SignOut(gh<_i961.AuthRepository>()),
    );
    gh.lazySingleton<_i37.SignUp>(
      () => _i37.SignUp(gh<_i961.AuthRepository>()),
    );
    gh.lazySingleton<_i895.NoteBloc>(
      () => _i895.NoteBloc(
        getAllNotes: gh<_i522.GetAllNotes>(),
        createNote: gh<_i1060.CreateNote>(),
        updateNote: gh<_i397.UpdateNote>(),
        deleteNote: gh<_i567.DeleteNote>(),
      ),
    );
    gh.lazySingleton<_i797.AuthBloc>(
      () => _i797.AuthBloc(
        signIn: gh<_i265.SignIn>(),
        signUp: gh<_i37.SignUp>(),
        signOut: gh<_i420.SignOut>(),
        authStateChanges: gh<_i323.AuthStateChanges>(),
      ),
    );
    gh.lazySingleton<_i1044.AuthRouterNotifier>(
      () => _i1044.AuthRouterNotifier(gh<_i797.AuthBloc>()),
    );
    gh.factory<_i313.AuthGuard>(() => _i313.AuthGuard(gh<_i797.AuthBloc>()));
    gh.factory<_i447.GuestGuard>(() => _i447.GuestGuard(gh<_i797.AuthBloc>()));
    gh.factory<_i734.SplashGuard>(
      () => _i734.SplashGuard(gh<_i797.AuthBloc>()),
    );
    gh.lazySingleton<_i81.AppRouter>(
      () => _i81.AppRouter(
        gh<_i313.AuthGuard>(),
        guestGuard: gh<_i447.GuestGuard>(),
        splashGuard: gh<_i734.SplashGuard>(),
      ),
    );
    return this;
  }
}

class _$AppDatabase extends _i982.AppDatabase {}

class _$FirebaseModule extends _i616.FirebaseModule {}
