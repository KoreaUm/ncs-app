import '../db/database_helper.dart';
import '../models/attempt.dart';

abstract class AttemptRepository {
  Future<void> saveAttempt(Attempt attempt, List<AttemptItem> items);
  Future<List<Attempt>> getAttemptsForUser(String? userId);
  Future<List<AttemptItem>> getItemsForAttempt(String attemptId);
  Future<List<AttemptItem>> getAllWrongItems(String? userId);
}

class SqfliteAttemptRepository implements AttemptRepository {
  final DatabaseHelper _dbHelper;
  SqfliteAttemptRepository({DatabaseHelper? dbHelper})
      : _dbHelper = dbHelper ?? DatabaseHelper.instance;

  @override
  Future<void> saveAttempt(Attempt attempt, List<AttemptItem> items) async {
    final db = await _dbHelper.database;
    final batch = db.batch();
    batch.insert('attempts', attempt.toMap());
    for (final item in items) {
      batch.insert('attempt_items', item.toMap());
    }
    await batch.commit(noResult: true);
  }

  @override
  Future<List<Attempt>> getAttemptsForUser(String? userId) async {
    final db = await _dbHelper.database;
    final rows = userId == null
        ? await db.query('attempts', where: 'userId IS NULL')
        : await db.query('attempts', where: 'userId = ?', whereArgs: [userId]);
    final attempts = rows.map(Attempt.fromMap).toList();
    attempts.sort((a, b) => b.startedAt.compareTo(a.startedAt));
    return attempts;
  }

  @override
  Future<List<AttemptItem>> getItemsForAttempt(String attemptId) async {
    final db = await _dbHelper.database;
    final rows = await db.query(
      'attempt_items',
      where: 'attemptId = ?',
      whereArgs: [attemptId],
    );
    return rows.map(AttemptItem.fromMap).toList();
  }

  @override
  Future<List<AttemptItem>> getAllWrongItems(String? userId) async {
    final attempts = await getAttemptsForUser(userId);
    final result = <AttemptItem>[];
    for (final attempt in attempts) {
      final items = await getItemsForAttempt(attempt.id);
      result.addAll(items.where((i) => !i.isCorrect));
    }
    return result;
  }
}
