part of 'workout_session_cubit.dart';

class WorkoutSessionState extends Equatable {
  final int elapsedSeconds;
  final bool isRunning;
  final int currentExerciseIndex;
  final Map<int, int> completedSets;
  final int restSecondsRemaining;
  final bool isResting;

  const WorkoutSessionState({
    this.elapsedSeconds = 0,
    this.isRunning = false,
    this.currentExerciseIndex = 0,
    this.completedSets = const {},
    this.restSecondsRemaining = 0,
    this.isResting = false,
  });

  WorkoutSessionState copyWith({
    int? elapsedSeconds,
    bool? isRunning,
    int? currentExerciseIndex,
    Map<int, int>? completedSets,
    int? restSecondsRemaining,
    bool? isResting,
  }) {
    return WorkoutSessionState(
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
      isRunning: isRunning ?? this.isRunning,
      currentExerciseIndex: currentExerciseIndex ?? this.currentExerciseIndex,
      completedSets: completedSets ?? this.completedSets,
      restSecondsRemaining: restSecondsRemaining ?? this.restSecondsRemaining,
      isResting: isResting ?? this.isResting,
    );
  }

  @override
  List<Object?> get props => [
        elapsedSeconds,
        isRunning,
        currentExerciseIndex,
        completedSets,
        restSecondsRemaining,
        isResting,
      ];
}

// Export formatDuration for use by screens.
// ignore: non_constant_identifier_names
final FormatDuration = formatDuration;
