import 'package:flutter/material.dart';
import '../models/auth_user.dart';

class AuthProvider with ChangeNotifier {
  AuthUser? _loggedInUser;

  final List<AuthUser> _users = [
    AuthUser(username: 'admin', password: '123456'),
    AuthUser(username: 'user1', password: 'password1'),
  ];

  bool login(String username, String password) {
    final user = _users.firstWhere(
      (u) => u.username == username && u.password == password,
      orElse: () => AuthUser(username: '', password: ''),
    );

    if (user.username != '') {
      _loggedInUser = user;
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    _loggedInUser = null;
    notifyListeners();
  }

  bool get isAuthenticated => _loggedInUser != null;
  AuthUser? get loggedInUser => _loggedInUser;
}
