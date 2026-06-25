import 'package:octafit/core/utils/either.dart';
import 'package:octafit/core/errors/failure.dart';
import 'package:octafit/features/ai_motion_analyzer/domain/entities/motion_analysis.dart';

abstract class MotionAnalyzerRepository {
  Future<Either<Failure, MotionAnalysisResult>> analyzeImage({
    required MotionInput input,
  });

  Future<Either<Failure, MotionAnalysisResult>> analyzeVideo({
    required MotionInput input,
    void Function(double progress)? onProgress,
  });

  Future<Either<Failure, MotionAnalysisResult>> analyzeLive({
    required MotionInput input,
  });

  Future<Either<Failure, List<MotionHistoryEntry>>> getHistory();

  Future<Either<Failure, MotionAnalysisResult>> getAnalysisById(String id);
}

class MockMotionAnalyzerRepository implements MotionAnalyzerRepository {
  @override
  Future<Either<Failure, MotionAnalysisResult>> analyzeImage({required MotionInput input}) async {
    return Right(MotionAnalysisResult(
      exercise: input.movementType.name,
      overallScore: 82,
      jointAngles: [
        JointAngle(joint: 'Knee', currentAngle: 142.0, optimalAngle: 135.0, deviation: 7.0, status: 'fair'),
        JointAngle(joint: 'Hip', currentAngle: 95.0, optimalAngle: 90.0, deviation: 5.0, status: 'good'),
      ],
      balance: BalanceAnalysis(score: 85, weightDistribution: 48.0, stabilityIndex: 0.92, assessment: 'Good balance'),
      speed: SpeedAnalysis(velocity: 2.5, acceleration: 4.8, reactionTime: 0.3, assessment: 'Good speed'),
      technique: TechniqueEvaluation(
        score: 78, strengths: ['Good form', 'Proper breathing'],
        weaknesses: ['Slight forward lean'], corrections: ['Keep chest up'],
      ),
      movementAccuracy: 0.81,
      tips: ['Engage core throughout movement', 'Control descent phase'],
      warnings: ['Avoid rounding lower back'],
    ));
  }

  @override
  Future<Either<Failure, MotionAnalysisResult>> analyzeVideo({required MotionInput input, void Function(double progress)? onProgress}) async {
    return analyzeImage(input: input);
  }

  @override
  Future<Either<Failure, MotionAnalysisResult>> analyzeLive({required MotionInput input}) async {
    return analyzeImage(input: input);
  }

  @override
  Future<Either<Failure, List<MotionHistoryEntry>>> getHistory() async {
    return Right([
      MotionHistoryEntry(id: '1', exercise: 'Squat', score: 85, date: DateTime.now().subtract(const Duration(days: 1))),
      MotionHistoryEntry(id: '2', exercise: 'Bench Press', score: 78, date: DateTime.now().subtract(const Duration(days: 3))),
    ]);
  }

  @override
  Future<Either<Failure, MotionAnalysisResult>> getAnalysisById(String id) async {
    return analyzeImage(input: MotionInput(movementType: MovementType.squat));
  }
}



