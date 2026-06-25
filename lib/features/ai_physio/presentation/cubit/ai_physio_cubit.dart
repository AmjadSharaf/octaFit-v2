import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:octafit/core/errors/failure.dart';
import 'package:octafit/core/utils/either.dart';
import 'package:octafit/features/ai_physio/domain/entities/injury_assessment.dart';
import 'package:octafit/features/ai_physio/domain/entities/physio_input.dart';
import 'package:octafit/features/ai_physio/domain/repositories/ai_physio_repository.dart';
import 'package:octafit/features/ai_physio/presentation/cubit/daily_protocol_item.dart';

part 'ai_physio_state.dart';

class AiPhysioCubit extends Cubit<AiPhysioState> {
  final AiPhysioRepository _repository;

  AiPhysioCubit({required AiPhysioRepository repository})
      : _repository = repository,
        super(const AiPhysioState());

  static const _bodyAreaToPainLocation = {
    'Knee': PainLocation.knee,
    'Lower Back': PainLocation.lowerBack,
    'Shoulder': PainLocation.shoulder,
    'Ankle': PainLocation.ankle,
    'Hip': PainLocation.hip,
    'Neck': PainLocation.neck,
  };

  void selectBodyArea(String area) {
    emit(state.copyWith(selectedBodyArea: area));
  }

  void setPainLevel(double level) {
    emit(state.copyWith(painLevel: level));
  }

  Future<void> submitAssessment() async {
    final area = state.selectedBodyArea;
    if (area == null) return;

    final location = _bodyAreaToPainLocation[area];
    if (location == null) return;

    final severity = switch (state.painLevel.round()) {
      1 || 2 || 3 => PainSeverity.mild,
      4 || 5      => PainSeverity.moderate,
      6 || 7 || 8 => PainSeverity.severe,
      _           => PainSeverity.verySevere,
    };

    final input = PhysioInput(
      painLocation: location,
      painType: PainType.aching,
      durationDays: 1,
      severity: severity,
    );

    await assessInjury(input);
    await generateRehabPlan(input);
  }

  Future<void> assessInjury(PhysioInput input) async {
    emit(state.copyWith(status: AiPhysioStatus.assessing));
    final result = await _repository.assessInjury(input);
    if (result is Left<Failure, InjuryAssessment>) {
      emit(state.copyWith(
        status: AiPhysioStatus.error,
        errorMessage: result.value.message,
      ));
    } else if (result is Right<Failure, InjuryAssessment>) {
      emit(state.copyWith(
        status: AiPhysioStatus.assessmentReady,
        assessment: result.value,
      ));
    }
  }

  Future<void> generateRehabPlan(PhysioInput input) async {
    emit(state.copyWith(status: AiPhysioStatus.generatingPlan));
    final result = await _repository.generateRehabPlan(input);
    if (result is Left<Failure, RehabilitationPlan>) {
      emit(state.copyWith(
        status: AiPhysioStatus.error,
        errorMessage: result.value.message,
      ));
    } else if (result is Right<Failure, RehabilitationPlan>) {
      final plan = result.value;
      emit(state.copyWith(
        status: AiPhysioStatus.planReady,
        rehabPlan: plan,
        dailyProtocol: _buildDailyProtocol(plan),
      ));
    }
  }

  Future<void> generateStretchingRoutine(PhysioInput input) async {
    emit(state.copyWith(status: AiPhysioStatus.generatingPlan));
    final result = await _repository.generateStretchingRoutine(input);
    if (result is Right<Failure, RehabilitationPlan>) {
      emit(state.copyWith(
        status: AiPhysioStatus.planReady,
        rehabPlan: result.value,
      ));
    }
  }

  Future<void> generateStrengtheningExercises(PhysioInput input) async {
    emit(state.copyWith(status: AiPhysioStatus.generatingPlan));
    final result = await _repository.generateStrengtheningExercises(input);
    if (result is Right<Failure, RehabilitationPlan>) {
      emit(state.copyWith(
        status: AiPhysioStatus.planReady,
        rehabPlan: result.value,
      ));
    }
  }

  Future<void> generatePreventionPlan(PhysioInput input) async {
    emit(state.copyWith(status: AiPhysioStatus.generatingPlan));
    final result = await _repository.generatePreventionPlan(input);
    if (result is Right<Failure, PreventionRecommendation>) {
      emit(state.copyWith(
        status: AiPhysioStatus.planReady,
        preventionPlan: result.value,
      ));
    }
  }

  void reset() {
    emit(const AiPhysioState());
  }

  static List<DailyProtocolItem> _buildDailyProtocol(RehabilitationPlan plan) {
    const weekLabels = [
      'Pain relief & mobility',
      'Activation & stability',
      'Active recovery',
      'Progressive loading',
      'Strength integration',
      'Return to training',
      'Reassessment',
    ];
    const weekDurations = [
      '15 min',
      '18 min',
      '20 min',
      '25 min',
      '28 min',
      '30 min',
      '10 min',
    ];
    final exercisePool = plan.exercises.map((e) => e.name).toList();
    return List.generate(7, (i) {
      final exercises = exercisePool.isEmpty
          ? ['Rest & recovery', 'Gentle movement', 'Monitor progress']
          : [...exercisePool];
      return DailyProtocolItem(
        day: 'Day ${i + 1}',
        focus: weekLabels[i],
        exercises: exercises,
        duration: weekDurations[i],
      );
    });
  }
}
