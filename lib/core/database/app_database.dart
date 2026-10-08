import 'package:flutter_todo_app/core/database/database_config.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'notes_table.dart';

@module
abstract class AppDatabase {


  @preResolve
  @singleton
  Future<Database> get database async {
    final path = p.join(await getDatabasesPath(), DatabaseConfig.dbFileName);
    return openDatabase(
      path,
      version: DatabaseConfig.dbVersion,
      onCreate: (db, version) async {
        await db.execute(NotesTable.createTable);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if(oldVersion < 2) {
          await db.execute('ALTER TABLE notes ADD COLUMN user_id TEXT NOT NULL DEFAULT ""');
          await db.execute(NotesTable.createUserIndex);
        }
      },
    );
  }
}