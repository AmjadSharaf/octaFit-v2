import 'package:equatable/equatable.dart';

class HomeUserSummary extends Equatable {
  final String id;
  final String name;
  final String username;
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

  const HomeUserSummary({
    required this.id,
    required this.name,
    required this.username,
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

  HomeUserSummary copyWith({
    String? id, String? name, String? username, String? initials,
    String? bio, String? goal, String? level, int? age,
    double? weight, double? height, bool? isPro,
    int? workouts, int? streak, int? followers, int? prs,
  }) {
    return HomeUserSummary(
      id: id ?? this.id, name: name ?? this.name,
      username: username ?? this.username, initials: initials ?? this.initials,
      bio: bio ?? this.bio, goal: goal ?? this.goal,
      level: level ?? this.level, age: age ?? this.age,
      weight: weight ?? this.weight, height: height ?? this.height,
      isPro: isPro ?? this.isPro, workouts: workouts ?? this.workouts,
      streak: streak ?? this.streak, followers: followers ?? this.followers,
      prs: prs ?? this.prs,
    );
  }

  @override
  List<Object?> get props => [
        id, name, username, initials, bio, goal, level, age, weight, height,
        isPro, workouts, streak, followers, prs,
      ];
}

class WeeklyStats extends Equatable {
  final int calories;
  final int workouts;
  final double hours;

  const WeeklyStats({
    required this.calories,
    required this.workouts,
    required this.hours,
  });

  @override
  List<Object?> get props => [calories, workouts, hours];
}

class DashboardPostSummary extends Equatable {
  final String id;
  final String user;
  final String avatar;
  final String time;
  final String content;
  final int likes;
  final int comments;
  final String icon;

  const DashboardPostSummary({
    required this.id,
    required this.user,
    required this.avatar,
    required this.time,
    required this.content,
    required this.likes,
    required this.comments,
    required this.icon,
  });

  @override
  List<Object?> get props => [id, user, avatar, time, content, likes, comments, icon];
}

class DashboardProgramSummary extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String icon;
  final String category;
  final String level;
  final String duration;
  final int workouts;
  final double rating;
  final int progress;

  const DashboardProgramSummary({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.category,
    required this.level,
    required this.duration,
    required this.workouts,
    required this.rating,
    required this.progress,
  });

  @override
  List<Object?> get props => [
        id, title, subtitle, icon, category, level, duration, workouts, rating, progress,
      ];
}

class DashboardData extends Equatable {
  final HomeUserSummary user;
  final WeeklyStats weeklyStats;
  final List<DashboardProgramSummary> programs;
  final List<DashboardPostSummary> posts;
  final String aiInsight;

  const DashboardData({
    required this.user,
    required this.weeklyStats,
    required this.programs,
    required this.posts,
    this.aiInsight = 'Your recovery score is at 87% today.',
  });

  @override
  List<Object?> get props => [user, weeklyStats, programs, posts, aiInsight];
}
