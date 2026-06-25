import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
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

  const UserEntity({
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

  UserEntity copyWith({
    String? id,
    String? name,
    String? username,
    String? email,
    String? initials,
    String? bio,
    String? goal,
    String? level,
    int? age,
    double? weight,
    double? height,
    bool? isPro,
    int? workouts,
    int? streak,
    int? followers,
    int? prs,
  }) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,
      initials: initials ?? this.initials,
      bio: bio ?? this.bio,
      goal: goal ?? this.goal,
      level: level ?? this.level,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      isPro: isPro ?? this.isPro,
      workouts: workouts ?? this.workouts,
      streak: streak ?? this.streak,
      followers: followers ?? this.followers,
      prs: prs ?? this.prs,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        username,
        email,
        initials,
        bio,
        goal,
        level,
        age,
        weight,
        height,
        isPro,
        workouts,
        streak,
        followers,
        prs,
      ];
}
