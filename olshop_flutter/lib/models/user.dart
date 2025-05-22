class User {
  final String id;
  final String username;
  final String email;
  final String? imagePath; // tambahkan ini, nullable supaya opsional

  User({
    required this.id,
    required this.username,
    required this.email,
    this.imagePath,
  });
}
