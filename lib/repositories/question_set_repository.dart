import 'dart:math';

import '../db/database_helper.dart';
import '../models/question_set.dart';

abstract class QuestionSetRepository {
  Future<QuestionSet?> getByShareCode(String shareCode);
  Future<List<QuestionSet>> getAll();
  Future<void> create(QuestionSet set);
  Future<void> delete(String id);
}

class SqfliteQuestionSetRepository implements QuestionSetRepository {
  final DatabaseHelper _dbHelper;
  SqfliteQuestionSetRepository({DatabaseHelper? dbHelper})
      : _dbHelper = dbHelper ?? DatabaseHelper.instance;

  static String generateShareCode() {
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    final rand = Random();
    return List.generate(6, (_) => chars[rand.nextInt(chars.length)]).join();
  }

  @override
  Future<List<QuestionSet>> getAll() async {
    final db = await _dbHelper.database;
    final rows = await db.query('question_sets');
    return rows.map(QuestionSet.fromMap).toList();
  }

  @override
  Future<QuestionSet?> getByShareCode(String shareCode) async {
    final db = await _dbHelper.database;
    final rows = await db.query(
      'question_sets',
      where: 'shareCode = ?',
      whereArgs: [shareCode.toUpperCase()],
    );
    if (rows.isEmpty) return null;
    return QuestionSet.fromMap(rows.first);
  }

  @override
  Future<void> create(QuestionSet set) async {
    final db = await _dbHelper.database;
    await db.insert('question_sets', set.toMap());
  }

  @override
  Future<void> delete(String id) async {
    final db = await _dbHelper.database;
    await db.delete('question_sets', where: 'id = ?', whereArgs: [id]);
  }
}
