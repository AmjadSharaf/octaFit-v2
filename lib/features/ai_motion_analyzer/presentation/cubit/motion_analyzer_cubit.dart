import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:octafit/core/errors/failure.dart';
import 'package:octafit/core/utils/either.dart';
import 'package:octafit/features/ai_motion_analyzer/domain/entities/motion_analysis.dart';
import 'package:octafit/features/ai_motion_analyzer/domain/repositories/motion_analyzer_repository.dart';

part 'motion_analyzer_state.dart';

class MotionAnalyzerCubit extends Cubit<MotionAnalyzerState> {
  final MotionAnalyzerRepository _repository;

  MotionAnalyzerCubit({required MotionAnalyzerRepository repository})
      : _repository = repository,
        super(const MotionAnalyzerState());

  static const _stepLabels = [
    'Detecting body landmarks',
    'Measuring joint angles',
    'Comparing to optimal form',
    'Generating recommendations',
  ];

  void selectExercise(MovementType type) {
    emit(state.copyWith(movementType: type));
  }

  void uploadVideo(String filePath) {
    emit(state.copyWith(
      status: MotionAnalyzerStatus.uploading,
      videoPath: filePath,
    ));
  }

  Future<void> startAnalysisFlow(String videoPath) async {
    if (state.movementType == null) {
      emit(state.copyWith(
        status: MotionAnalyzerStatus.error,
        errorMessage: 'Please select an exercise first',
      ));
      return;
    }

    emit(state.copyWith(
      status: MotionAnalyzerStatus.uploading,
      videoPath: videoPath,
    ));
    await Future<void>.delayed(const Duration(milliseconds: 300));

    emit(state.copyWith(
      status: MotionAnalyzerStatus.processing,
      processingProgress: 0,
      currentStep: 0,
    ));

    await _simulateProcessingStep(0.3, 30, 1);
    await _simulateProcessingStep(0.3, 60, 2);
    await _simulateProcessingStep(0.3, 90, 3);
    await _simulateProcessingStep(0.3, 100, 3);

    final input = MotionInput(
      movementType: state.movementType!,
      videoPath: videoPath,
    );
    final result = await _repository.analyzeVideo(input: input);
    _handleAnalysisResult(result);
  }

  Future<void> _simulateProcessingStep(
    double delaySec,
    double progress,
    int step,
  ) async {
    await Future<void>.delayed(
      Duration(milliseconds: (delaySec * 1000).toInt()),
    );
    if (!isClosed) {
      emit(state.copyWith(
        processingProgress: progress,
        currentStep: step,
      ));
    }
  }

  void _handleAnalysisResult(Either<Failure, MotionAnalysisResult> result) {
    if (result is Left<Failure, MotionAnalysisResult>) {
      emit(state.copyWith(
        status: MotionAnalyzerStatus.error,
        errorMessage: result.value.message,
      ));
    } else if (result is Right<Failure, MotionAnalysisResult>) {
      emit(state.copyWith(
        status: MotionAnalyzerStatus.completed,
        analysisResult: result.value,
      ));
    }
  }

  void setAnalysisResult(MotionAnalysisResult result) {
    emit(state.copyWith(
      status: MotionAnalyzerStatus.completed,
      analysisResult: result,
    ));
  }

  Future<void> loadHistory() async {
    final result = await _repository.getHistory();
    if (result is Right<Failure, List<MotionHistoryEntry>>) {
      emit(state.copyWith(history: result.value));
    }
  }

  void reset() {
    emit(const MotionAnalyzerState());
  }
}
