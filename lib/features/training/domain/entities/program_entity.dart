import 'package:equatable/equatable.dart';

class ProgramEntity extends Equatable {
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

  const ProgramEntity({
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
