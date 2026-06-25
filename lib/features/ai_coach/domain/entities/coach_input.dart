import 'package:equatable/equatable.dart';

enum SportType {
  general,
  running,
  cycling,
  swimming,
  weightlifting,
  mma,
  boxing,
  basketball,
  football,
  yoga,
  crossfit,
  calisthenics,
}

enum FitnessGoal {
  weightLoss,
  muscleGain,
  endurance,
  strength,
  flexibility,
  generalFitness,
  sportPerformance,
  rehabilitation,
}

enum TrainingExperience {
  beginner,
  intermediate,
  advanced,
  elite,
}

class CoachInput extends Equatable {
  final int age;
  final double height;
  final double weight;
  final double? bodyFatPercentage;
  final String gender;
  final TrainingExperience experience;
  final SportType sportType;
  final FitnessGoal goal;
  final List<String>? injuries;
  final int? trainingDaysPerWeek;
  final int? sessionDurationMinutes;

  const CoachInput({
    required this.age,
    required this.height,
    required this.weight,
    this.bodyFatPercentage,
    required this.gender,
    required this.experience,
    required this.sportType,
    required this.goal,
    this.injuries,
    this.trainingDaysPerWeek,
    this.sessionDurationMinutes,
  });

  CoachInput copyWith({
    int? age,
    double? height,
    double? weight,
    double? bodyFatPercentage,
    String? gender,
    TrainingExperience? experience,
    SportType? sportType,
    FitnessGoal? goal,
    List<String>? injuries,
    int? trainingDaysPerWeek,
    int? sessionDurationMinutes,
  }) {
    return CoachInput(
      age: age ?? this.age,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      bodyFatPercentage: bodyFatPercentage ?? this.bodyFatPercentage,
      gender: gender ?? this.gender,
      experience: experience ?? this.experience,
      sportType: sportType ?? this.sportType,
      goal: goal ?? this.goal,
      injuries: injuries ?? this.injuries,
      trainingDaysPerWeek: trainingDaysPerWeek ?? this.trainingDaysPerWeek,
      sessionDurationMinutes:
          sessionDurationMinutes ?? this.sessionDurationMinutes,
    );
  }

  @override
  List<Object?> get props => [
        age,
        height,
        weight,
        bodyFatPercentage,
        gender,
        experience,
        sportType,
        goal,
        injuries,
        trainingDaysPerWeek,
        sessionDurationMinutes,
      ];
}
