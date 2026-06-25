part of 'motion_analyzer_cubit.dart';

enum MotionAnalyzerStatus {
  idle,
  uploading,
  processing,
  completed,
  error,
}

class MotionAnalyzerState extends Equatable {
  final MotionAnalyzerStatus status;
  final MovementType? movementType;
  final String? videoPath;
  final MotionAnalysisResult? analysisResult;
  final List<MotionHistoryEntry> history;
  final String? errorMessage;
  final double processingProgress;
  final int currentStep;

  const MotionAnalyzerState({
    this.status = MotionAnalyzerStatus.idle,
    this.movementType,
    this.videoPath,
    this.analysisResult,
    this.history = const [],
    this.errorMessage,
    this.processingProgress = 0.0,
    this.currentStep = 0,
  });

  bool get isLoading => status == MotionAnalyzerStatus.uploading ||
      status == MotionAnalyzerStatus.processing;

  int get totalSteps => MotionAnalyzerCubit._stepLabels.length;

  String get currentStepLabel =>
      currentStep < totalSteps ? MotionAnalyzerCubit._stepLabels[currentStep] : '';

  bool get stepCompleted =>
      currentStep >= totalSteps;

  MotionAnalyzerState copyWith({
    MotionAnalyzerStatus? status,
    MovementType? movementType,
    String? videoPath,
    MotionAnalysisResult? analysisResult,
    List<MotionHistoryEntry>? history,
    String? errorMessage,
    double? processingProgress,
    int? currentStep,
    bool clearError = false,
  }) {
    return MotionAnalyzerState(
      status: status ?? this.status,
      movementType: movementType ?? this.movementType,
      videoPath: videoPath ?? this.videoPath,
      analysisResult: analysisResult ?? this.analysisResult,
      history: history ?? this.history,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      processingProgress: processingProgress ?? this.processingProgress,
      currentStep: currentStep ?? this.currentStep,
    );
  }

  @override
  List<Object?> get props => [
        status,
        movementType,
        videoPath,
        analysisResult,
        history,
        errorMessage,
        processingProgress,
        currentStep,
      ];
}
