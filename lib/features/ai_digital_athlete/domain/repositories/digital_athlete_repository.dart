import 'package:octafit/core/utils/either.dart';
import 'package:octafit/core/errors/failure.dart';
import 'package:octafit/features/ai_digital_athlete/domain/entities/athlete_data.dart';
import 'package:octafit/features/ai_digital_athlete/domain/entities/athlete_predictions.dart';

abstract class DigitalAthleteRepository {
  Future<Either<Failure, AthleteData>> getAthleteData(String userId);

  Future<Either<Failure, AthleteData>> updateBodyMeasurements({
    required String userId,
    required BodyMeasurements measurements,
  });

  Future<Either<Failure, AthleteData>> updateWeight({
    required String userId,
    required double weight,
  });

  Future<Either<Failure, AthleteData>> addProgressPhoto({
    required String userId,
    required String imagePath,
    String? notes,
  });

  Future<Either<Failure, AthleteData>> updatePerformanceMetrics({
    required String userId,
    required PerformanceMetrics metrics,
  });

  Future<Either<Failure, AthleteData>> updateInjuryHistory({
    required String userId,
    required InjuryHistory history,
  });

  Future<Either<Failure, AthletePredictions>> getPredictions(String userId);

  Future<Either<Failure, AthletePredictions>> predictWeight({
    required String userId,
    required int weeksAhead,
  });

  Future<Either<Failure, AthletePredictions>> predictBodyFat({
    required String userId,
    required int weeksAhead,
  });

  Future<Either<Failure, AthletePredictions>> predictStrengthProgression({
    required String userId,
    required int weeksAhead,
  });

  Future<Either<Failure, double>> predictInjuryProbability({
    required String userId,
  });
}

class MockDigitalAthleteRepository implements DigitalAthleteRepository {
  @override
  Future<Either<Failure, AthleteData>> getAthleteData(String userId) async {
    return Right(AthleteData(
      id: userId, weight: 75.0, height: 178.0, bodyFatPercentage: 15.0,
      muscleMass: 35.0, bmi: 23.7,
      measurements: BodyMeasurements(chest: 100, waist: 80, hips: 95, leftBicep: 35, rightBicep: 35, leftThigh: 55, rightThigh: 55, leftCalf: 37, rightCalf: 37),
      progressPhotos: [],
      performance: PerformanceMetrics(
        maxBenchPress: 80, maxSquat: 120, maxDeadlift: 140,
        maxPullUps: 12, maxPushUps: 40, fiveKmRunTime: 420,
        verticalJump: 45, sprintSpeed: 7.5,
      ),
      injuryHistory: InjuryHistory(
        pastInjuries: [PastInjury(bodyPart: 'Knee', injuryType: 'Strain', date: DateTime(2023, 6), recoveryStatus: 'Full recovery')],
        chronicConditions: [],
      ),
      fitnessScores: FitnessScores(
        overallFitness: 67, strength: 75, endurance: 65, flexibility: 55,
        cardiovascular: 60, power: 70, agility: 68,
      ),
    ));
  }

  @override
  Future<Either<Failure, AthleteData>> updateBodyMeasurements({required String userId, required BodyMeasurements measurements}) async {
    final data = await getAthleteData(userId);
    return data;
  }

  @override
  Future<Either<Failure, AthleteData>> updateWeight({required String userId, required double weight}) async {
    final data = await getAthleteData(userId);
    return data;
  }

  @override
  Future<Either<Failure, AthleteData>> addProgressPhoto({required String userId, required String imagePath, String? notes}) async {
    final data = await getAthleteData(userId);
    return data;
  }

  @override
  Future<Either<Failure, AthleteData>> updatePerformanceMetrics({required String userId, required PerformanceMetrics metrics}) async {
    final data = await getAthleteData(userId);
    return data;
  }

  @override
  Future<Either<Failure, AthleteData>> updateInjuryHistory({required String userId, required InjuryHistory history}) async {
    final data = await getAthleteData(userId);
    return data;
  }

  @override
  Future<Either<Failure, AthletePredictions>> getPredictions(String userId) async {
    return Right(AthletePredictions(
      predictedWeight: 72.5,
      predictedBodyFat: 12.5,
      predictedMuscleMass: 38.0,
      strengthProgression: {1: 80, 4: 87, 8: 100},
      injuryProbability: 0.15,
      fitnessProjections: [
        FitnessProjection(date: DateTime.now(), predictedScore: 75.0, confidenceInterval: 2.5),
        FitnessProjection(date: DateTime.now().add(const Duration(days: 28)), predictedScore: 74.0, confidenceInterval: 3.0),
        FitnessProjection(date: DateTime.now().add(const Duration(days: 56)), predictedScore: 72.5, confidenceInterval: 3.5),
      ],
    ));
  }

  @override
  Future<Either<Failure, AthletePredictions>> predictWeight({required String userId, required int weeksAhead}) async {
    return getPredictions(userId);
  }

  @override
  Future<Either<Failure, AthletePredictions>> predictBodyFat({required String userId, required int weeksAhead}) async {
    return getPredictions(userId);
  }

  @override
  Future<Either<Failure, AthletePredictions>> predictStrengthProgression({required String userId, required int weeksAhead}) async {
    return getPredictions(userId);
  }

  @override
  Future<Either<Failure, double>> predictInjuryProbability({required String userId}) async {
    return Right(0.15);
  }
}



