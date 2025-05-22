class AuthUser {
  final String userId;
  final String username;
  final String password;
  final String email;
  final String? imagePath;

  AuthUser({
    required this.userId,
    required this.username,
    required this.password,
    this.email = '',
    this.imagePath,
  });
}
