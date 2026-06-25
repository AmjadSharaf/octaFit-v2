import 'package:equatable/equatable.dart';

enum MovementType {
  punch,
  kick,
  squat,
  deadlift,
  benchPress,
  overheadPress,
  pullUp,
  lunge,
  defensiveMovement,
  sprint,
  jump,
  custom,
}

class MotionInput extends Equatable {
  final MovementType movementType;
  final String? imagePath;
  final String? videoPath;
  final bool useLiveCamera;

  const MotionInput({
    required this.movementType,
    this.imagePath,
    this.videoPath,
    this.useLiveCamera = false,
  });

  @override
  List<Object?> get props => [movementType, imagePath, videoPath, useLiveCamera];
}

class MotionAnalysisResult extends Equatable {
  final String exercise;
  final int overallScore;
  final List<JointAngle> jointAngles;
  final BalanceAnalysis balance;
  final SpeedAnalysis speed;
  final TechniqueEvaluation technique;
  final double movementAccuracy;
  final List<String> tips;
  final List<String> warnings;

  const MotionAnalysisResult({
    required this.exercise,
    required this.overallScore,
    required this.jointAngles,
    required this.balance,
    required this.speed,
    required this.technique,
    required this.movementAccuracy,
    required this.tips,
    required this.warnings,
  });

  @override
  List<Object?> get props => [
        exercise,
        overallScore,
        jointAngles,
        balance,
        speed,
        technique,
        movementAccuracy,
        tips,
        warnings,
      ];
}

class JointAngle extends Equatable {
  final String joint;
  final double currentAngle;
  final double optimalAngle;
  final double deviation;
  final String status;

  const JointAngle({
    required this.joint,
    required this.currentAngle,
    required this.optimalAngle,
    required this.deviation,
    required this.status,
  });

  @override
  List<Object?> get props =>
      [joint, currentAngle, optimalAngle, deviation, status];
}

class BalanceAnalysis extends Equatable {
  final double score;
  final double weightDistribution;
  final double stabilityIndex;
  final String assessment;

  const BalanceAnalysis({
    required this.score,
    required this.weightDistribution,
    required this.stabilityIndex,
    required this.assessment,
  });

  @override
  List<Object?> get props =>
      [score, weightDistribution, stabilityIndex, assessment];
}

class SpeedAnalysis extends Equatable {
  final double velocity;
  final double acceleration;
  final double reactionTime;
  final String assessment;

  const SpeedAnalysis({
    required this.velocity,
    required this.acceleration,
    required this.reactionTime,
    required this.assessment,
  });

  @override
  List<Object?> get props => [velocity, acceleration, reactionTime, assessment];
}

class TechniqueEvaluation extends Equatable {
  final int score;
  final List<String> strengths;
  final List<String> weaknesses;
  final List<String> corrections;

  const TechniqueEvaluation({
    required this.score,
    required this.strengths,
    required this.weaknesses,
    required this.corrections,
  });

  @override
  List<Object?> get props => [score, strengths, weaknesses, corrections];
}

class MotionHistoryEntry extends Equatable {
  final String id;
  final String exercise;
  final int score;
  final DateTime date;
  final String? videoThumbnail;

  const MotionHistoryEntry({
    required this.id,
    required this.exercise,
    required this.score,
    required this.date,
    this.videoThumbnail,
  });

  @override
  List<Object?> get props => [id, exercise, score, date, videoThumbnail];
}
