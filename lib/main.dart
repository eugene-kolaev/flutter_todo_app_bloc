import 'package:flutter/material.dart';

import 'app.dart';
import 'core/database/app_database.dart';
import 'features/notes/data/repository/notes_repository_impl.dart';
import 'features/notes/domain/repository/notes_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final db = await AppDatabase.open();
  final NotesRepository repository = NotesRepositoryImpl(db);

  runApp(App(repository: repository));
}



