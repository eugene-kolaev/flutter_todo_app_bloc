// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:sqflite/sqflite.dart' as _i779;

import '../../features/notes/data/repository/notes_repository_impl.dart'
    as _i467;
import '../../features/notes/domain/repository/notes_repository.dart' as _i505;
import '../../features/notes/domain/usecases/create_note.dart' as _i1060;
import '../../features/notes/domain/usecases/delete_note.dart' as _i567;
import '../../features/notes/domain/usecases/get_all_notes.dart' as _i522;
import '../../features/notes/domain/usecases/update_note.dart' as _i397;
import '../../features/notes/presentation/bloc/note_bloc.dart' as _i895;
import '../database/app_database.dart' as _i982;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appDatabase = _$AppDatabase();
    await gh.singletonAsync<_i779.Database>(
      () => appDatabase.database,
      preResolve: true,
    );
    gh.lazySingleton<_i505.NotesRepository>(
      () => _i467.NotesRepositoryImpl(gh<_i779.Database>()),
    );
    gh.factory<_i1060.CreateNote>(
      () => _i1060.CreateNote(gh<_i505.NotesRepository>()),
    );
    gh.factory<_i567.DeleteNote>(
      () => _i567.DeleteNote(gh<_i505.NotesRepository>()),
    );
    gh.factory<_i522.GetAllNotes>(
      () => _i522.GetAllNotes(gh<_i505.NotesRepository>()),
    );
    gh.factory<_i397.UpdateNote>(
      () => _i397.UpdateNote(gh<_i505.NotesRepository>()),
    );
    gh.factory<_i895.NoteBloc>(
      () => _i895.NoteBloc(
        getAllNotes: gh<_i522.GetAllNotes>(),
        createNote: gh<_i1060.CreateNote>(),
        updateNote: gh<_i397.UpdateNote>(),
        deleteNote: gh<_i567.DeleteNote>(),
      ),
    );
    return this;
  }
}

class _$AppDatabase extends _i982.AppDatabase {}
