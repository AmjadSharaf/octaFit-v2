import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:octafit/core/errors/failure.dart';
import 'package:octafit/core/utils/either.dart';
import 'package:octafit/features/home/domain/entities/home_data.dart';
import 'package:octafit/features/home/domain/repositories/home_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _repository;

  HomeCubit({required HomeRepository repository})
      : _repository = repository,
        super(const HomeState());

  Future<void> loadDashboard() async {
    emit(state.copyWith(status: HomeStatus.loading));
    final result = await _repository.loadDashboard();
    if (result is Left<Failure, DashboardData>) {
      emit(state.copyWith(
        status: HomeStatus.error,
        errorMessage: result.value.message,
      ));
    } else if (result is Right<Failure, DashboardData>) {
      final data = result.value;
      emit(state.copyWith(
        status: HomeStatus.loaded,
        user: data.user,
        programs: data.programs,
        posts: data.posts,
        weeklyCalories: data.weeklyStats.calories,
        weeklyWorkouts: data.weeklyStats.workouts,
        weeklyHours: data.weeklyStats.hours,
        aiInsight: data.aiInsight,
      ));
    }
  }

  void selectProgram(String programId) {
    emit(state.copyWith(selectedProgramId: programId));
  }

  void refresh() {
    loadDashboard();
  }
}
