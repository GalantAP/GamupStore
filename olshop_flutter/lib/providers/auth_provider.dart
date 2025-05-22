import 'package:flutter/material.dart';
import '../models/auth_user.dart';

class AuthProvider with ChangeNotifier {
  AuthUser? _loggedInUser;

  final List<AuthUser> _users = [
    AuthUser(
      userId: '1',
      username: 'Galant17',
      password: '123456',
      email: 'admin@example.com',
      imagePath: 'assets/images/admin.jpg',
    ),
    AuthUser(
      userId: '2',
      username: 'user1',
      password: 'password1',
      email: 'user1@example.com',
    ),
  ];

  bool login(String username, String password) {
    try {
      final user = _users.firstWhere(
        (u) => u.username == username && u.password == password,
      );
      _loggedInUser = user;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  void logout() {
    _loggedInUser = null;
    notifyListeners();
  }

  bool get isAuthenticated => _loggedInUser != null;

  String? get userId => _loggedInUser?.userId;
  String? get username => _loggedInUser?.username;
  String? get email => _loggedInUser?.email;
  String? get imagePath => _loggedInUser?.imagePath;

  AuthUser? get loggedInUser => _loggedInUser;
}
