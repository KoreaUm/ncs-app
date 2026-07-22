import 'package:flutter/foundation.dart';

import '../models/user.dart';
import '../repositories/user_repository.dart';

class SessionProvider extends ChangeNotifier {
  final UserRepository _userRepository;
  SessionProvider({UserRepository? userRepository})
      : _userRepository = userRepository ?? SqfliteUserRepository();

  User? _currentUser;
  bool _isGuest = false;
  bool _adminModeActive = false;

  User? get currentUser => _currentUser;
  bool get isGuest => _isGuest;
  bool get isLoggedIn => _currentUser != null;
  bool get adminModeActive => _adminModeActive;
  String? get userId => _currentUser?.id;

  void startGuest() {
    _currentUser = null;
    _isGuest = true;
    _adminModeActive = false;
    notifyListeners();
  }

  Future<void> login(String name, String email, {bool isAdmin = false}) async {
    final user =
        await _userRepository.createOrLogin(name, email, isAdmin: isAdmin);
    _currentUser = user;
    _isGuest = false;
    notifyListeners();
  }

  void enterAdminMode() {
    _adminModeActive = true;
    notifyListeners();
  }

  void exitAdminMode() {
    _adminModeActive = false;
    notifyListeners();
  }

  void logout() {
    _currentUser = null;
    _isGuest = false;
    _adminModeActive = false;
    notifyListeners();
  }
}
