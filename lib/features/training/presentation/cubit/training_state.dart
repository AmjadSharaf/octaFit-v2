part of 'training_cubit.dart';

enum TrainingStatus { initial, loading, loaded, error }

class TrainingState extends Equatable {
  final TrainingStatus status;
  final List<ProgramEntity> programs;
  final List<ExerciseEntity> exercises;
  final WorkoutSessionEntity? workoutSession;
  final String programFilter;
  final String exerciseFilter;
  final String exerciseSearch;
  final String? selectedProgramId;
  final String? selectedExerciseId;
  final String? errorMessage;

  const TrainingState({
    this.status = TrainingStatus.initial,
    this.programs = const [],
    this.exercises = const [],
    this.workoutSession,
    this.programFilter = 'All',
    this.exerciseFilter = 'All',
    this.exerciseSearch = '',
    this.selectedProgramId,
    this.selectedExerciseId,
    this.errorMessage,
  });

  ProgramEntity? get selectedProgram {
    if (selectedProgramId == null || programs.isEmpty) return null;
    return programs.firstWhere(
      (p) => p.id == selectedProgramId,
      orElse: () => programs.first,
    );
  }

  ExerciseEntity? get selectedExercise {
    if (selectedExerciseId == null || exercises.isEmpty) return null;
    return exercises.firstWhere(
      (e) => e.id == selectedExerciseId,
      orElse: () => exercises.first,
    );
  }

  TrainingState copyWith({
    TrainingStatus? status,
    List<ProgramEntity>? programs,
    List<ExerciseEntity>? exercises,
    WorkoutSessionEntity? workoutSession,
    String? programFilter,
    String? exerciseFilter,
    String? exerciseSearch,
    String? selectedProgramId,
    String? selectedExerciseId,
    String? errorMessage,
    bool clearSession = false,
  }) {
    return TrainingState(
      status: status ?? this.status,
      programs: programs ?? this.programs,
      exercises: exercises ?? this.exercises,
      workoutSession: clearSession ? null : (workoutSession ?? this.workoutSession),
      programFilter: programFilter ?? this.programFilter,
      exerciseFilter: exerciseFilter ?? this.exerciseFilter,
      exerciseSearch: exerciseSearch ?? this.exerciseSearch,
      selectedProgramId: selectedProgramId ?? this.selectedProgramId,
      selectedExerciseId: selectedExerciseId ?? this.selectedExerciseId,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        programs,
        exercises,
        workoutSession,
        programFilter,
        exerciseFilter,
        exerciseSearch,
        selectedProgramId,
        selectedExerciseId,
        errorMessage,
      ];
}
