import 'package:octafit/core/utils/either.dart';
import 'package:octafit/core/errors/failure.dart';
import 'package:octafit/features/ai_physio/domain/entities/injury_assessment.dart';
import 'package:octafit/features/ai_physio/domain/entities/physio_input.dart';

abstract class AiPhysioRepository {
  Future<Either<Failure, InjuryAssessment>> assessInjury(
    PhysioInput input,
  );

  Future<Either<Failure, RehabilitationPlan>> generateRehabPlan(
    PhysioInput input,
  );

  Future<Either<Failure, RehabilitationPlan>> generateStretchingRoutine(
    PhysioInput input,
  );

  Future<Either<Failure, RehabilitationPlan>> generateStrengtheningExercises(
    PhysioInput input,
  );

  Future<Either<Failure, PreventionRecommendation>> generatePreventionPlan(
    PhysioInput input,
  );
}

class MockAiPhysioRepository implements AiPhysioRepository {
  @override
  Future<Either<Failure, InjuryAssessment>> assessInjury(PhysioInput input) async {
    return Right(InjuryAssessment(
      diagnosis: 'Possible ${input.painLocation.name} strain',
      confidenceScore: 78,
      description: 'Based on your symptoms, this appears to be a mild-to-moderate strain of the ${input.painLocation.name} area.',
      possibleConditions: ['Muscle strain', 'Tendonitis', 'Overuse injury'],
      requiresProfessionalCare: input.severity == PainSeverity.severe || input.severity == PainSeverity.verySevere,
      recommendedSpecialist: input.severity == PainSeverity.verySevere ? 'Orthopedic specialist' : null,
      urgency: input.severity == PainSeverity.verySevere ? 'Immediate' : 'Within 2 weeks',
    ));
  }

  @override
  Future<Either<Failure, RehabilitationPlan>> generateRehabPlan(PhysioInput input) async {
    return Right(RehabilitationPlan(
      id: 'rp1',
      name: '${input.painLocation.name} Rehabilitation',
      description: 'Structured rehab plan for your ${input.painLocation.name} injury',
      durationWeeks: 6,
      exercises: [
        RehabExercise(name: 'Range of motion', category: 'mobility', sets: 3, reps: 10, holdSeconds: 0, frequency: 'Daily', description: 'Gentle ROM exercises'),
        RehabExercise(name: 'Isometric holds', category: 'strengthening', sets: 3, reps: 5, holdSeconds: 10, frequency: 'Every other day', description: 'Isometric holds at pain-free angles'),
      ],
      precautions: ['Avoid painful movements', 'Stop if pain increases', 'Ice after exercises'],
      recoveryMilestones: ['Week 2: Pain-free ROM', 'Week 4: Return to light activity', 'Week 6: Full recovery'],
    ));
  }

  @override
  Future<Either<Failure, RehabilitationPlan>> generateStretchingRoutine(PhysioInput input) async {
    return Right(RehabilitationPlan(
      id: 'st1', name: 'Stretching Routine', description: 'Daily stretching for ${input.painLocation.name}',
      durationWeeks: 4, exercises: [], precautions: [], recoveryMilestones: [],
    ));
  }

  @override
  Future<Either<Failure, RehabilitationPlan>> generateStrengtheningExercises(PhysioInput input) async {
    return Right(RehabilitationPlan(
      id: 'stg1', name: 'Strengthening Program', description: 'Progressive strengthening',
      durationWeeks: 8, exercises: [], precautions: [], recoveryMilestones: [],
    ));
  }

  @override
  Future<Either<Failure, PreventionRecommendation>> generatePreventionPlan(PhysioInput input) async {
    return Right(PreventionRecommendation(
      title: '${input.painLocation.name} Injury Prevention',
      description: 'Prevent future injuries with these recommendations',
      tips: ['Warm up properly before exercise', 'Maintain good form', 'Don\'t skip rest days'],
      exercises: ['Core strengthening', 'Flexibility training', 'Balance exercises'],
    ));
  }
}



