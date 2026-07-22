import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._internal();
  static final DatabaseHelper instance = DatabaseHelper._internal();

  Database? _db;

  Future<Database> get database async {
    _db ??= await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, 'ncs_app.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
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
