import 'package:octafit/core/utils/either.dart';
import 'package:octafit/core/errors/failure.dart';
import 'package:octafit/features/training/domain/entities/program_entity.dart';
import 'package:octafit/features/training/domain/entities/exercise_entity.dart';
import 'package:octafit/features/training/domain/entities/workout_session_entity.dart';

abstract class TrainingRepository {
  Future<Either<Failure, List<ProgramEntity>>> getPrograms();
  Future<Either<Failure, List<ExerciseEntity>>> getExercises();
  Future<Either<Failure, WorkoutSessionEntity>> getWorkoutSession();
}

class MockTrainingRepository implements TrainingRepository {
  @override
  Future<Either<Failure, List<ProgramEntity>>> getPrograms() async {
    return Right([
      ProgramEntity(
        id: 'p1', title: 'MMA Conditioning', subtitle: 'Full body power',
        icon: '🥊', category: 'MMA', level: 'Intermediate',
        duration: '8 weeks', workouts: 24, rating: 4.8, progress: 60,
      ),
      ProgramEntity(
        id: 'p2', title: 'Strength Foundations', subtitle: 'Build raw strength',
        icon: '🏋️', category: 'Strength', level: 'Beginner',
        duration: '12 weeks', workouts: 36, rating: 4.9, progress: 20,
      ),
      ProgramEntity(
        id: 'p3', title: 'Home HIIT', subtitle: 'No equipment needed',
        icon: '🔥', category: 'HIIT', level: 'All Levels',
        duration: '4 weeks', workouts: 20, rating: 4.7, progress: 0,
      ),
    ]);
  }

  @override
  Future<Either<Failure, List<ExerciseEntity>>> getExercises() async {
    return Right([
      ExerciseEntity(id: 'e1', name: 'Barbell Squat', muscle: 'Legs', equipment: 'Barbell', sets: 4, reps: '8-10', rest: '90s'),
      ExerciseEntity(id: 'e2', name: 'Bench Press', muscle: 'Chest', equipment: 'Barbell', sets: 4, reps: '8-10', rest: '90s'),
      ExerciseEntity(id: 'e3', name: 'Deadlift', muscle: 'Back', equipment: 'Barbell', sets: 3, reps: '5', rest: '120s'),
      ExerciseEntity(id: 'e4', name: 'Pull-up', muscle: 'Back', equipment: 'Bodyweight', sets: 3, reps: '8-12', rest: '60s'),
      ExerciseEntity(id: 'e5', name: 'Overhead Press', muscle: 'Shoulders', equipment: 'Dumbbell', sets: 3, reps: '10-12', rest: '60s'),
    ]);
  }

  @override
  Future<Either<Failure, WorkoutSessionEntity>> getWorkoutSession() async {
    return Right(WorkoutSessionEntity(
      title: 'Upper Body Power',
      duration: 45,
      exercises: [
        SessionExerciseEntity(name: 'Bench Press', sets: 4, reps: 8, weight: 80, completed: 0),
        SessionExerciseEntity(name: 'Pull-up', sets: 3, reps: 10, weight: 0, completed: 0),
        SessionExerciseEntity(name: 'Overhead Press', sets: 3, reps: 10, weight: 30, completed: 0),
      ],
    ));
  }
}
