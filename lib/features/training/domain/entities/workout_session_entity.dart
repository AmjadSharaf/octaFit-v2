import 'package:equatable/equatable.dart';

class SessionExerciseEntity extends Equatable {
  final String name;
  final int sets;
  final int reps;
  final double weight;
  final int completed;

  const SessionExerciseEntity({
    required this.name,
    required this.sets,
    required this.reps,
    required this.weight,
    required this.completed,
  });

  @override
  List<Object?> get props => [name, sets, reps, weight, completed];
}

class WorkoutSessionEntity extends Equatable {
  final String title;
  final int duration;
  final List<SessionExerciseEntity> exercises;

  const WorkoutSessionEntity({
    required this.title,
    required this.duration,
    required this.exercises,
  });

  @override
  List<Object?> get props => [title, duration, exercises];
}
