import 'package:equatable/equatable.dart';

class WorkoutPlan extends Equatable {
  final String id;
  final String name;
  final String description;
  final int durationWeeks;
  final List<WorkoutDay> days;
  final String intensity;
  final String focus;

  const WorkoutPlan({
    required this.id,
    required this.name,
    required this.description,
    required this.durationWeeks,
    required this.days,
    required this.intensity,
    required this.focus,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        durationWeeks,
        days,
        intensity,
        focus,
      ];
}

class WorkoutDay extends Equatable {
  final int day;
  final String name;
  final List<PlannedExercise> exercises;
  final String? notes;

  const WorkoutDay({
    required this.day,
    required this.name,
    required this.exercises,
    this.notes,
  });

  @override
  List<Object?> get props => [day, name, exercises, notes];
}

class PlannedExercise extends Equatable {
  final String name;
  final int sets;
  final int reps;
  final double? weight;
  final int? durationSeconds;
  final int restSeconds;
  final String? notes;

  const PlannedExercise({
    required this.name,
    required this.sets,
    required this.reps,
    this.weight,
    this.durationSeconds,
    required this.restSeconds,
    this.notes,
  });

  @override
  List<Object?> get props => [
        name,
        sets,
        reps,
        weight,
        durationSeconds,
        restSeconds,
        notes,
      ];
}
