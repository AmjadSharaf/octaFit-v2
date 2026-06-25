import 'package:equatable/equatable.dart';

class AthleteData extends Equatable {
  final String id;
  final double weight;
  final double height;
  final double? bodyFatPercentage;
  final double? muscleMass;
  final double? boneMass;
  final double? bodyWater;
  final double? bmi;
  final double? bmr;
  final BodyMeasurements measurements;
  final List<ProgressPhoto> progressPhotos;
  final PerformanceMetrics performance;
  final InjuryHistory injuryHistory;
  final FitnessScores fitnessScores;

  const AthleteData({
    required this.id,
    required this.weight,
    required this.height,
    this.bodyFatPercentage,
    this.muscleMass,
    this.boneMass,
    this.bodyWater,
    this.bmi,
    this.bmr,
    required this.measurements,
    required this.progressPhotos,
    required this.performance,
    required this.injuryHistory,
    required this.fitnessScores,
  });

  AthleteData copyWith({
    String? id,
    double? weight,
    double? height,
    double? bodyFatPercentage,
    double? muscleMass,
    double? boneMass,
    double? bodyWater,
    double? bmi,
    double? bmr,
    BodyMeasurements? measurements,
    List<ProgressPhoto>? progressPhotos,
    PerformanceMetrics? performance,
    InjuryHistory? injuryHistory,
    FitnessScores? fitnessScores,
  }) {
    return AthleteData(
      id: id ?? this.id,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      bodyFatPercentage: bodyFatPercentage ?? this.bodyFatPercentage,
      muscleMass: muscleMass ?? this.muscleMass,
      boneMass: boneMass ?? this.boneMass,
      bodyWater: bodyWater ?? this.bodyWater,
      bmi: bmi ?? this.bmi,
      bmr: bmr ?? this.bmr,
      measurements: measurements ?? this.measurements,
      progressPhotos: progressPhotos ?? this.progressPhotos,
      performance: performance ?? this.performance,
      injuryHistory: injuryHistory ?? this.injuryHistory,
      fitnessScores: fitnessScores ?? this.fitnessScores,
    );
  }

  @override
  List<Object?> get props => [
        id,
        weight,
        height,
        bodyFatPercentage,
        muscleMass,
        boneMass,
        bodyWater,
        bmi,
        bmr,
        measurements,
        progressPhotos,
        performance,
        injuryHistory,
        fitnessScores,
      ];
}

class BodyMeasurements extends Equatable {
  final double? neck;
  final double? shoulders;
  final double? chest;
  final double? leftBicep;
  final double? rightBicep;
  final double? leftForearm;
  final double? rightForearm;
  final double? waist;
  final double? hips;
  final double? leftThigh;
  final double? rightThigh;
  final double? leftCalf;
  final double? rightCalf;

  const BodyMeasurements({
    this.neck,
    this.shoulders,
    this.chest,
    this.leftBicep,
    this.rightBicep,
    this.leftForearm,
    this.rightForearm,
    this.waist,
    this.hips,
    this.leftThigh,
    this.rightThigh,
    this.leftCalf,
    this.rightCalf,
  });

  @override
  List<Object?> get props => [
        neck,
        shoulders,
        chest,
        leftBicep,
        rightBicep,
        leftForearm,
        rightForearm,
        waist,
        hips,
        leftThigh,
        rightThigh,
        leftCalf,
        rightCalf,
      ];
}

class ProgressPhoto extends Equatable {
  final String id;
  final String imageUrl;
  final DateTime date;
  final double? weight;
  final String? notes;

  const ProgressPhoto({
    required this.id,
    required this.imageUrl,
    required this.date,
    this.weight,
    this.notes,
  });

  @override
  List<Object?> get props => [id, imageUrl, date, weight, notes];
}

class PerformanceMetrics extends Equatable {
  final double? maxBenchPress;
  final double? maxSquat;
  final double? maxDeadlift;
  final double? maxOverheadPress;
  final double? oneRmSquat;
  final double? oneRmBench;
  final double? oneRmDeadlift;
  final double? fiveKmRunTime;
  final double? tenKmRunTime;
  final int? maxPullUps;
  final int? maxPushUps;
  final double? verticalJump;
  final double? sprintSpeed;

  const PerformanceMetrics({
    this.maxBenchPress,
    this.maxSquat,
    this.maxDeadlift,
    this.maxOverheadPress,
    this.oneRmSquat,
    this.oneRmBench,
    this.oneRmDeadlift,
    this.fiveKmRunTime,
    this.tenKmRunTime,
    this.maxPullUps,
    this.maxPushUps,
    this.verticalJump,
    this.sprintSpeed,
  });

  @override
  List<Object?> get props => [
        maxBenchPress,
        maxSquat,
        maxDeadlift,
        maxOverheadPress,
        oneRmSquat,
        oneRmBench,
        oneRmDeadlift,
        fiveKmRunTime,
        tenKmRunTime,
        maxPullUps,
        maxPushUps,
        verticalJump,
        sprintSpeed,
      ];
}

class InjuryHistory extends Equatable {
  final List<PastInjury> pastInjuries;
  final List<String> chronicConditions;

  const InjuryHistory({
    required this.pastInjuries,
    required this.chronicConditions,
  });

  @override
  List<Object?> get props => [pastInjuries, chronicConditions];
}

class PastInjury extends Equatable {
  final String bodyPart;
  final String injuryType;
  final DateTime date;
  final String? recoveryStatus;

  const PastInjury({
    required this.bodyPart,
    required this.injuryType,
    required this.date,
    this.recoveryStatus,
  });

  @override
  List<Object?> get props => [bodyPart, injuryType, date, recoveryStatus];
}

class FitnessScores extends Equatable {
  final int overallFitness;
  final int strength;
  final int endurance;
  final int flexibility;
  final int cardiovascular;
  final int power;
  final int agility;

  const FitnessScores({
    required this.overallFitness,
    required this.strength,
    required this.endurance,
    required this.flexibility,
    required this.cardiovascular,
    required this.power,
    required this.agility,
  });

  @override
  List<Object?> get props => [
        overallFitness,
        strength,
        endurance,
        flexibility,
        cardiovascular,
        power,
        agility,
      ];
}
