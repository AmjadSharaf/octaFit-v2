import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:octafit/core/errors/failure.dart';
import 'package:octafit/core/utils/either.dart';
import 'package:octafit/features/training/domain/entities/exercise_entity.dart';
import 'package:octafit/features/training/domain/entities/program_entity.dart';
import 'package:octafit/features/training/domain/entities/workout_session_entity.dart';
import 'package:octafit/features/training/domain/repositories/training_repository.dart';

part 'training_state.dart';

class TrainingCubit extends Cubit<TrainingState> {
  final TrainingRepository _repository;

  TrainingCubit({required TrainingRepository repository})
      : _repository = repository,
        super(const TrainingState());

  List<ProgramEntity> get filteredPrograms {
    if (state.programFilter == 'All') return state.programs;
    return state.programs
        .where((p) =>
            p.category.toLowerCase() == state.programFilter.toLowerCase())
        .toList();
  }

  List<ExerciseEntity> get filteredExercises {
    var result = state.exercises;
    if (state.exerciseFilter != 'All') {
      result = result
          .where((e) =>
              e.muscle.toLowerCase() == state.exerciseFilter.toLowerCase())
          .toList();
    }
    if (state.exerciseSearch.isNotEmpty) {
      final q = state.exerciseSearch.toLowerCase();
      result = result
          .where((e) =>
              e.name.toLowerCase().contains(q) ||
              e.muscle.toLowerCase().contains(q))
          .toList();
    }
    return result;
  }

  Future<void> loadPrograms() async {
    emit(state.copyWith(status: TrainingStatus.loading));
    final result = await _repository.getPrograms();
    if (result is Left<Failure, List<ProgramEntity>>) {
      emit(state.copyWith(
        status: TrainingStatus.error,
        errorMessage: result.value.message,
      ));
    } else if (result is Right<Failure, List<ProgramEntity>>) {
      emit(state.copyWith(
        status: TrainingStatus.loaded,
        programs: result.value,
      ));
    }
  }

  Future<void> loadExercises() async {
    final result = await _repository.getExercises();
    if (result is Right<Failure, List<ExerciseEntity>>) {
      emit(state.copyWith(exercises: result.value));
    }
  }

  Future<void> loadWorkoutSession() async {
    emit(state.copyWith(status: TrainingStatus.loading));
    final result = await _repository.getWorkoutSession();
    if (result is Left<Failure, WorkoutSessionEntity>) {
      emit(state.copyWith(
        status: TrainingStatus.error,
        errorMessage: result.value.message,
      ));
    } else if (result is Right<Failure, WorkoutSessionEntity>) {
      emit(state.copyWith(
        status: TrainingStatus.loaded,
        workoutSession: result.value,
      ));
    }
  }

  void setProgramFilter(String filter) {
    emit(state.copyWith(programFilter: filter));
  }

  void selectProgram(String id) {
    emit(state.copyWith(selectedProgramId: id));
  }

  void setExerciseFilter(String filter) {
    emit(state.copyWith(exerciseFilter: filter));
  }

  void setExerciseSearch(String query) {
    emit(state.copyWith(exerciseSearch: query));
  }

  void selectExercise(String id) {
    emit(state.copyWith(selectedExerciseId: id));
  }

  void setExercises(List<ExerciseEntity> exercises) {
    emit(state.copyWith(
      status: TrainingStatus.loaded,
      exercises: exercises,
    ));
  }
}
