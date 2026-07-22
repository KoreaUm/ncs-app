import 'package:sqflite/sqflite.dart';

import '../db/database_helper.dart';
import '../models/category.dart';
import '../models/question.dart';
import '../seed/seed_questions.dart';

abstract class QuestionRepository {
  Future<List<Question>> getAll();
  Future<List<Question>> getByCategories(List<NcsCategory> categories);
  Future<List<Question>> getByIds(List<String> ids);
  Future<Question?> getById(String id);
  Future<void> insert(Question question);
  Future<void> insertAll(List<Question> questions);
  Future<void> update(Question question);
  Future<void> delete(String id);
  Future<Map<NcsCategory, int>> countByCategory();
  Future<void> ensureSeeded();
}

class SqfliteQuestionRepository implements QuestionRepository {
  final DatabaseHelper _dbHelper;
  SqfliteQuestionRepository({DatabaseHelper? dbHelper})
      : _dbHelper = dbHelper ?? DatabaseHelper.instance;

  @override
  Future<void> ensureSeeded() async {
    final db = await _dbHelper.database;
    final count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM questions'));
    if (count == 0) {
      await insertAll(buildSeedQuestions());
    }
  }

  @override
  Future<List<Question>> getAll() async {
    final db = await _dbHelper.database;
    final rows = await db.query('questions');
    return rows.map(Question.fromMap).toList();
  }

  @override
  Future<List<Question>> getByCategories(List<NcsCategory> categories) async {
    if (categories.isEmpty) return getAll();
    final db = await _dbHelper.database;
    final placeholders = List.filled(categories.length, '?').join(',');
    final rows = await db.query(
      'questions',
      where: 'category IN ($placeholders)',
      whereArgs: categories.map((e) => e.code).toList(),
    );
    return rows.map(Question.fromMap).toList();
  }

  @override
  Future<List<Question>> getByIds(List<String> ids) async {
    if (ids.isEmpty) return [];
    final db = await _dbHelper.database;
    final placeholders = List.filled(ids.length, '?').join(',');
    final rows = await db.query(
      'questions',
      where: 'id IN ($placeholders)',
      whereArgs: ids,
    );
    final map = {for (final r in rows.map(Question.fromMap)) r.id: r};
    return ids.where(map.containsKey).map((id) => map[id]!).toList();
  }

  @override
  Future<Question?> getById(String id) async {
    final db = await _dbHelper.database;
    final rows = await db.query('questions', where: 'id = ?', whereArgs: [id]);
    if (rows.isEmpty) return null;
    return Question.fromMap(rows.first);
  }

  @override
  Future<void> insert(Question question) async {
    final db = await _dbHelper.database;
    await db.insert('questions', question.toMap());
  }

  @override
  Future<void> insertAll(List<Question> questions) async {
    final db = await _dbHelper.database;
    final batch = db.batch();
    for (final q in questions) {
      batch.insert('questions', q.toMap());
    }
    await batch.commit(noResult: true);
  }

  @override
  Future<void> update(Question question) async {
    final db = await _dbHelper.database;
    await db.update('questions', question.toMap(),
        where: 'id = ?', whereArgs: [question.id]);
  }

  @override
  Future<void> delete(String id) async {
    final db = await _dbHelper.database;
    await db.delete('questions', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<Map<NcsCategory, int>> countByCategory() async {
    final db = await _dbHelper.database;
    final rows = await db.rawQuery(
        'SELECT category, COUNT(*) as cnt FROM questions GROUP BY category');
    final result = {for (final c in NcsCategory.values) c: 0};
    for (final row in rows) {
      final category = NcsCategoryX.fromCode(row['category'] as String);
      result[category] = row['cnt'] as int;
    }
    return result;
  }
}
