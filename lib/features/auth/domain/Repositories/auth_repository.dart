class User {
  final String id;
  final String email;
  final String? name;

  User({required this.id, required this.email, this.name});
}

abstract class AuthRepository {
  Future<User?> getCurrentUser();
  Future<User> login(String email, String password);
  Future<User> register(String email, String password, String name);
  Future<void> logout();
}