import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'workout_session_state.dart';

class WorkoutSessionCubit extends Cubit<WorkoutSessionState> {
  Timer? _timer;

  WorkoutSessionCubit() : super(const WorkoutSessionState());

  void startWorkout() {
    if (state.isRunning) return;
    emit(state.copyWith(isRunning: true));
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (state.isResting && state.restSecondsRemaining > 0) {
        final remaining = state.restSecondsRemaining - 1;
        emit(state.copyWith(
          restSecondsRemaining: remaining,
          isResting: remaining > 0,
        ));
      }
      emit(state.copyWith(elapsedSeconds: state.elapsedSeconds + 1));
    });
  }

  void pauseWorkout() {
    _timer?.cancel();
    emit(state.copyWith(isRunning: false));
  }

  void completeSet(int exerciseIndex, int totalSets) {
    final current = state.completedSets[exerciseIndex] ?? 0;
    if (current >= totalSets) return;

    final updated = Map<int, int>.from(state.completedSets);
    updated[exerciseIndex] = current + 1;
    emit(state.copyWith(
      completedSets: updated,
      isResting: true,
      restSecondsRemaining: 60,
    ));
  }

  void skipRest() {
    emit(state.copyWith(isResting: false, restSecondsRemaining: 0));
  }

  void goToExercise(int index) {
    emit(state.copyWith(currentExerciseIndex: index));
  }

  void reset() {
    _timer?.cancel();
    emit(const WorkoutSessionState());
  }

  @override
  void emit(WorkoutSessionState state) {
    if (!isClosed) super.emit(state);
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}

String formatDuration(int totalSeconds) {
  final minutes = totalSeconds ~/ 60;
  final seconds = totalSeconds % 60;
  return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
}
