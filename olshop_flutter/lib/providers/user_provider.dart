import 'package:flutter/foundation.dart';

class User {
  final String id;
  final String username;
  final String email;
  final String imagePath;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.imagePath,
  });
}

class UserProvider with ChangeNotifier {
  User? _user;

  /// Getter user aktif
  User? get user => _user;

  /// Cek apakah user sedang login
  bool get isLoggedIn => _user != null;

  /// Getter data user spesifik
  String get userId => _user?.id ?? '';
  String get username => _user?.username ?? 'User';
  String get email => _user?.email ?? 'email@example.com';
  String get imagePath =>
      _user?.imagePath ?? 'assets/images/banner/admin.jpg';

  /// Login user
  void login({
    required String id,
    required String username,
    required String email,
    String? imagePath,
  }) {
    _user = User(
      id: id,
      username: username,
      email: email,
      imagePath: imagePath ??
          'assets/images/banner/admin.jpg', // default gambar
    );
    notifyListeners();
  }

  /// Logout user
  void logout() {
    _user = null;
    notifyListeners();
  }

  /// Update profile user aktif
  void updateUser({
    String? username,
    String? email,
    String? imagePath,
  }) {
    if (_user != null) {
      _user = User(
        id: _user!.id,
        username: username ?? _user!.username,
        email: email ?? _user!.email,
        imagePath: imagePath ?? _user!.imagePath,
      );
      notifyListeners();
    }
  }
}
