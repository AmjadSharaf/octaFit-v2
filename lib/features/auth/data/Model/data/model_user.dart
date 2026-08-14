class User {
  final int id;
  final String name;
  final String email;
  final String? token;
  final String? type;
  final String? createdAt;
  final String? updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.token,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json, {String? token}) {
    final userData = json['user'] ?? json;
    return User(
      id: userData['id'],
      name: userData['name'] ?? '',
      email: userData['email'] ?? '',
      token: token ?? json['token'],
      type: json['type'],
      createdAt: userData['created_at'],
      updatedAt: userData['updated_at'],
    );
  }
}