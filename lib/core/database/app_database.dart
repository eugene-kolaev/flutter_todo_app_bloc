import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'notes_table.dart';

class AppDatabase {
  static const dbFileName = 'notes_database.db';
  static const dbVersion = 1;

  AppDatabase._();


  static Future<Database> open() async {
    final path = p.join(await getDatabasesPath(), dbFileName);
    return openDatabase(
      path,
      version: dbVersion,
      onCreate: (db, version) async {
        await db.execute(NotesTable.createTable);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
      },
    );
  }
}