import 'package:octafit/features/authentication/domain/entities/user_entity.dart';

class UserModel {
  final String id;
  final String name;
  final String username;
  final String email;
  final String initials;
  final String bio;
  final String goal;
  final String level;
  final int age;
  final double weight;
  final double height;
  final bool isPro;
  final int workouts;
  final int streak;
  final int followers;
  final int prs;

  const UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.initials,
    required this.bio,
    required this.goal,
    required this.level,
    required this.age,
    required this.weight,
    required this.height,
    required this.isPro,
    required this.workouts,
    required this.streak,
    required this.followers,
    required this.prs,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'].toString(),
      name: (json['name'] as String?) ?? '',
      username: (json['username'] as String?) ?? '',
      email: (json['email'] as String?) ?? '',
      initials: (json['initials'] as String?) ?? '',
      bio: (json['bio'] as String?) ?? '',
      goal: (json['goal'] as String?) ?? '',
      level: (json['level'] as String?) ?? '',
      age: (json['age'] as int?) ?? 0,
      weight: ((json['weight'] as num?)?.toDouble() ?? 0.0),
      height: ((json['height'] as num?)?.toDouble() ?? 0.0),
      isPro: (json['is_pro'] ?? json['isPro'] ?? false) as bool,
      workouts: (json['workouts'] as int?) ?? 0,
      streak: (json['streak'] as int?) ?? 0,
      followers: (json['followers'] as int?) ?? 0,
      prs: (json['prs'] as int?) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'initials': initials,
      'bio': bio,
      'goal': goal,
      'level': level,
      'age': age,
      'weight': weight,
      'height': height,
      'is_pro': isPro,
      'workouts': workouts,
      'streak': streak,
      'followers': followers,
      'prs': prs,
    };
  }

  UserEntity toEntity() => UserEntity(
        id: id,
        name: name,
        username: username,
        email: email,
        initials: initials,
        bio: bio,
        goal: goal,
        level: level,
        age: age,
        weight: weight,
        height: height,
        isPro: isPro,
        workouts: workouts,
        streak: streak,
        followers: followers,
        prs: prs,
      );

  factory UserModel.fromEntity(UserEntity entity) => UserModel(
        id: entity.id,
        name: entity.name,
        username: entity.username,
        email: entity.email,
        initials: entity.initials,
        bio: entity.bio,
        goal: entity.goal,
        level: entity.level,
        age: entity.age,
        weight: entity.weight,
        height: entity.height,
        isPro: entity.isPro,
        workouts: entity.workouts,
        streak: entity.streak,
        followers: entity.followers,
        prs: entity.prs,
      );
}
