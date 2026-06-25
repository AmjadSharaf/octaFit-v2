import 'package:equatable/equatable.dart';

class InjuryAssessment extends Equatable {
  final String diagnosis;
  final int confidenceScore;
  final String description;
  final List<String> possibleConditions;
  final bool requiresProfessionalCare;
  final String? recommendedSpecialist;
  final String urgency;

  const InjuryAssessment({
    required this.diagnosis,
    required this.confidenceScore,
    required this.description,
    required this.possibleConditions,
    required this.requiresProfessionalCare,
    this.recommendedSpecialist,
    required this.urgency,
  });

  @override
  List<Object?> get props => [
        diagnosis,
        confidenceScore,
        description,
        possibleConditions,
        requiresProfessionalCare,
        recommendedSpecialist,
        urgency,
      ];
}

class RehabilitationPlan extends Equatable {
  final String id;
  final String name;
  final String description;
  final int durationWeeks;
  final List<RehabExercise> exercises;
  final List<String> precautions;
  final List<String> recoveryMilestones;

  const RehabilitationPlan({
    required this.id,
    required this.name,
    required this.description,
    required this.durationWeeks,
    required this.exercises,
    required this.precautions,
    required this.recoveryMilestones,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        durationWeeks,
        exercises,
        precautions,
        recoveryMilestones,
      ];
}

class RehabExercise extends Equatable {
  final String name;
  final String category;
  final int sets;
  final int reps;
  final int holdSeconds;
  final String frequency;
  final String description;
  final String? videoUrl;

  const RehabExercise({
    required this.name,
    required this.category,
    required this.sets,
    required this.reps,
    required this.holdSeconds,
    required this.frequency,
    required this.description,
    this.videoUrl,
  });

  @override
  List<Object?> get props => [
        name,
        category,
        sets,
        reps,
        holdSeconds,
        frequency,
        description,
        videoUrl,
      ];
}

class PreventionRecommendation extends Equatable {
  final String title;
  final String description;
  final List<String> tips;
  final List<String> exercises;

  const PreventionRecommendation({
    required this.title,
    required this.description,
    required this.tips,
    required this.exercises,
  });

  @override
  List<Object?> get props => [title, description, tips, exercises];
}
