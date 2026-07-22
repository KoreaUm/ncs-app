import '../db/database_helper.dart';
import '../models/user.dart';

abstract class UserRepository {
  Future<User?> findByEmail(String email);
  Future<User> createOrLogin(String name, String email, {bool isAdmin = false});
}

class SqfliteUserRepository implements UserRepository {
  final DatabaseHelper _dbHelper;
  SqfliteUserRepository({DatabaseHelper? dbHelper})
      : _dbHelper = dbHelper ?? DatabaseHelper.instance;

  @override
  Future<User?> findByEmail(String email) async {
    final db = await _dbHelper.database;
    final rows =
        await db.query('users', where: 'email = ?', whereArgs: [email]);
    if (rows.isEmpty) return null;
    return User.fromMap(rows.first);
  }

  @override
  Future<User> createOrLogin(String name, String email,
      {bool isAdmin = false}) async {
    final existing = await findByEmail(email);
    if (existing != null) return existing;
    final db = await _dbHelper.database;
    final user = User(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: name,
      email: email,
      isAdmin: isAdmin,
    );
    await db.insert('users', user.toMap());
    return user;
  }
}
