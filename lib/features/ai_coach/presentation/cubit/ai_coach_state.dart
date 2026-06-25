part of 'ai_coach_cubit.dart';

enum AiCoachStatus {
  idle,
  generating,
  thinking,
  analyzing,
  workoutReady,
  nutritionReady,
  answerReady,
  analysisReady,
  error,
}

class ChatMessage extends Equatable {
  final String question;
  final String answer;
  final DateTime timestamp;

  ChatMessage({
    required this.question,
    required this.answer,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  @override
  List<Object?> get props => [question, answer, timestamp];
}

class AiCoachState extends Equatable {
  final AiCoachStatus status;
  final WorkoutPlan? workoutPlan;
  final NutritionPlan? nutritionPlan;
  final MealAnalysis? mealAnalysis;
  final CoachInput? userInput;
  final String? errorMessage;
  final List<ChatMessage> chatMessages;
  final List<String> alternatives;

  const AiCoachState({
    this.status = AiCoachStatus.idle,
    this.workoutPlan,
    this.nutritionPlan,
    this.mealAnalysis,
    this.userInput,
    this.errorMessage,
    this.chatMessages = const [],
    this.alternatives = const [],
  });

  bool get isLoading => status == AiCoachStatus.generating ||
      status == AiCoachStatus.thinking ||
      status == AiCoachStatus.analyzing;

  AiCoachState copyWith({
    AiCoachStatus? status,
    WorkoutPlan? workoutPlan,
    NutritionPlan? nutritionPlan,
    MealAnalysis? mealAnalysis,
    CoachInput? userInput,
    String? errorMessage,
    List<ChatMessage>? chatMessages,
    List<String>? alternatives,
    bool clearWorkout = false,
    bool clearNutrition = false,
    bool clearAnalysis = false,
    bool clearError = false,
  }) {
    return AiCoachState(
      status: status ?? this.status,
      workoutPlan: clearWorkout ? null : (workoutPlan ?? this.workoutPlan),
      nutritionPlan: clearNutrition ? null : (nutritionPlan ?? this.nutritionPlan),
      mealAnalysis: clearAnalysis ? null : (mealAnalysis ?? this.mealAnalysis),
      userInput: userInput ?? this.userInput,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      chatMessages: chatMessages ?? this.chatMessages,
      alternatives: alternatives ?? this.alternatives,
    );
  }

  @override
  List<Object?> get props => [
        status,
        workoutPlan,
        nutritionPlan,
        mealAnalysis,
        userInput,
        errorMessage,
        chatMessages,
        alternatives,
      ];
}
