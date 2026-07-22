import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class DatabaseHelper {
  DatabaseHelper._internal();
  static final DatabaseHelper instance = DatabaseHelper._internal();

  Database? _db;

  Future<Database> get database async {
    _db ??= await _initDatabase();
    return _db!;
  }

  // Bump this whenever lib/seed/seed_questions.dart content changes so
  // existing installs (native or web/IndexedDB) drop and reseed the
  // question bank instead of keeping stale hardcoded data forever.
  static const _dbVersion = 2;

  Future<Database> _initDatabase() async {
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
      return databaseFactory.openDatabase(
        'ncs_app.db',
        options: OpenDatabaseOptions(
          version: _dbVersion,
          onCreate: _onCreate,
          onUpgrade: _onUpgrade,
        ),
      );
    }
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, 'ncs_app.db');
    return openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    for (final table in [
      'questions',
      'question_sets',
      'attempts',
      'attempt_items',
      'users',
    ]) {
      await db.execute('DROP TABLE IF EXISTS $table');
    }
    await _onCreate(db, newVersion);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE questions (
        id TEXT PRIMARY KEY,
        category TEXT NOT NULL,
        difficulty TEXT NOT NULL,
        stem TEXT NOT NULL,
        choices TEXT NOT NULL,
        correctIndex INTEGER NOT NULL,
        explanation TEXT NOT NULL,
        tags TEXT NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE question_sets (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        categoryFilter TEXT NOT NULL,
        count INTEGER NOT NULL,
        questionIds TEXT NOT NULL,
        shareCode TEXT NOT NULL UNIQUE
      )
    ''');
    await db.execute('''
      CREATE TABLE attempts (
        id TEXT PRIMARY KEY,
        userId TEXT,
        questionIds TEXT NOT NULL,
        startedAt TEXT NOT NULL,
        finishedAt TEXT,
        totalTimeSeconds INTEGER NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE attempt_items (
        id TEXT PRIMARY KEY,
        attemptId TEXT NOT NULL,
        questionId TEXT NOT NULL,
        answerIndex INTEGER,
        isCorrect INTEGER NOT NULL,
        timeSpentSeconds INTEGER NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE users (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        isAdmin INTEGER NOT NULL
      )
    ''');
  }

  Future<void> resetForTest() async {
    final db = await database;
    await db.close();
    _db = null;
  }
}
