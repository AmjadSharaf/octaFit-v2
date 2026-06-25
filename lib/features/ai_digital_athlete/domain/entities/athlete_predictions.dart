import 'package:equatable/equatable.dart';

class AthletePredictions extends Equatable {
  final double? predictedWeight;
  final double? predictedBodyFat;
  final double? predictedMuscleMass;
  final Map<int, double>? strengthProgression;
  final double? injuryProbability;
  final List<FitnessProjection> fitnessProjections;

  const AthletePredictions({
    this.predictedWeight,
    this.predictedBodyFat,
    this.predictedMuscleMass,
    this.strengthProgression,
    this.injuryProbability,
    required this.fitnessProjections,
  });

  @override
  List<Object?> get props => [
        predictedWeight,
        predictedBodyFat,
        predictedMuscleMass,
        strengthProgression,
        injuryProbability,
        fitnessProjections,
      ];
}

class FitnessProjection extends Equatable {
  final DateTime date;
  final double predictedScore;
  final double confidenceInterval;

  const FitnessProjection({
    required this.date,
    required this.predictedScore,
    required this.confidenceInterval,
  });

  @override
  List<Object?> get props => [date, predictedScore, confidenceInterval];
}
