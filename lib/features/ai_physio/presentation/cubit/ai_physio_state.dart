part of 'ai_physio_cubit.dart';

enum AiPhysioStatus {
  idle,
  assessing,
  generatingPlan,
  assessmentReady,
  planReady,
  error,
}

class AiPhysioState extends Equatable {
  final AiPhysioStatus status;
  final PhysioInput? input;
  final InjuryAssessment? assessment;
  final RehabilitationPlan? rehabPlan;
  final PreventionRecommendation? preventionPlan;
  final String? errorMessage;
  final String? selectedBodyArea;
  final double painLevel;
  final List<DailyProtocolItem> dailyProtocol;

  const AiPhysioState({
    this.status = AiPhysioStatus.idle,
    this.input,
    this.assessment,
    this.rehabPlan,
    this.preventionPlan,
    this.errorMessage,
    this.selectedBodyArea,
    this.painLevel = 4,
    this.dailyProtocol = const [],
  });

  bool get isLoading => status == AiPhysioStatus.assessing ||
      status == AiPhysioStatus.generatingPlan;

  AiPhysioState copyWith({
    AiPhysioStatus? status,
    PhysioInput? input,
    InjuryAssessment? assessment,
    RehabilitationPlan? rehabPlan,
    PreventionRecommendation? preventionPlan,
    String? errorMessage,
    String? selectedBodyArea,
    double? painLevel,
    List<DailyProtocolItem>? dailyProtocol,
    bool clearError = false,
    bool clearSelectedBodyArea = false,
  }) {
    return AiPhysioState(
      status: status ?? this.status,
      input: input ?? this.input,
      assessment: assessment ?? this.assessment,
      rehabPlan: rehabPlan ?? this.rehabPlan,
      preventionPlan: preventionPlan ?? this.preventionPlan,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      selectedBodyArea: clearSelectedBodyArea ? null : (selectedBodyArea ?? this.selectedBodyArea),
      painLevel: painLevel ?? this.painLevel,
      dailyProtocol: dailyProtocol ?? this.dailyProtocol,
    );
  }

  @override
  List<Object?> get props => [
        status,
        input,
        assessment,
        rehabPlan,
        preventionPlan,
        errorMessage,
        selectedBodyArea,
        painLevel,
        dailyProtocol,
      ];
}
