import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:octafit/core/errors/failure.dart';
import 'package:octafit/core/utils/either.dart';
import 'package:octafit/features/ai_digital_athlete/domain/entities/athlete_data.dart';
import 'package:octafit/features/ai_digital_athlete/domain/entities/athlete_predictions.dart';
import 'package:octafit/features/ai_digital_athlete/domain/repositories/digital_athlete_repository.dart';

part 'digital_athlete_state.dart';

class DigitalAthleteCubit extends Cubit<DigitalAthleteState> {
  final DigitalAthleteRepository _repository;

  DigitalAthleteCubit({required DigitalAthleteRepository repository})
      : _repository = repository,
        super(const DigitalAthleteState());

  Future<void> loadAthleteData(String userId) async {
    emit(state.copyWith(status: DigitalAthleteStatus.loading));
    final result = await _repository.getAthleteData(userId);
    if (result is Left<Failure, AthleteData>) {
      emit(state.copyWith(
        status: DigitalAthleteStatus.error,
        errorMessage: result.value.message,
      ));
    } else if (result is Right<Failure, AthleteData>) {
      emit(state.copyWith(
        status: DigitalAthleteStatus.dataReady,
        athleteData: result.value,
      ));
    }
  }

  Future<void> updateWeight(double weight) async {
    final userId = state.athleteData?.id;
    if (userId == null) return;
    emit(state.copyWith(status: DigitalAthleteStatus.loading));
    final result = await _repository.updateWeight(userId: userId, weight: weight);
    if (result is Right<Failure, AthleteData>) {
      emit(state.copyWith(
        status: DigitalAthleteStatus.dataReady,
        athleteData: result.value,
      ));
    }
  }

  Future<void> updateMeasurements(BodyMeasurements measurements) async {
    final userId = state.athleteData?.id;
    if (userId == null) return;
    emit(state.copyWith(status: DigitalAthleteStatus.loading));
    final result = await _repository.updateBodyMeasurements(
      userId: userId,
      measurements: measurements,
    );
    if (result is Right<Failure, AthleteData>) {
      emit(state.copyWith(
        status: DigitalAthleteStatus.dataReady,
        athleteData: result.value,
      ));
    }
  }

  Future<void> addProgressPhoto(ProgressPhoto photo) async {
    final userId = state.athleteData?.id;
    if (userId == null) return;
    emit(state.copyWith(status: DigitalAthleteStatus.loading));
    final result = await _repository.addProgressPhoto(
      userId: userId,
      imagePath: photo.imageUrl,
    );
    if (result is Right<Failure, AthleteData>) {
      emit(state.copyWith(
        status: DigitalAthleteStatus.dataReady,
        athleteData: result.value,
      ));
    }
  }

  Future<void> loadPredictions(String userId) async {
    emit(state.copyWith(status: DigitalAthleteStatus.loading));
    final result = await _repository.getPredictions(userId);
    if (result is Left<Failure, AthletePredictions>) {
      emit(state.copyWith(
        status: DigitalAthleteStatus.error,
        errorMessage: result.value.message,
      ));
    } else if (result is Right<Failure, AthletePredictions>) {
      emit(state.copyWith(
        status: DigitalAthleteStatus.predictionsReady,
        predictions: result.value,
      ));
    }
  }

  void reset() {
    emit(const DigitalAthleteState());
  }
}
