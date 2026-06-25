import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:octafit/core/errors/failure.dart';
import 'package:octafit/core/utils/either.dart';
import 'package:octafit/features/ai_coach/domain/entities/coach_input.dart';
import 'package:octafit/features/ai_coach/domain/entities/meal_analysis.dart';
import 'package:octafit/features/ai_coach/domain/entities/nutrition_plan.dart';
import 'package:octafit/features/ai_coach/domain/entities/workout_plan.dart';
import 'package:octafit/features/ai_coach/domain/usecases/generate_workout_plan_usecase.dart';

part 'ai_coach_state.dart';

class AiCoachCubit extends Cubit<AiCoachState> {
  final GenerateWorkoutPlanUseCase _generateWorkoutPlan;
  final GenerateNutritionPlanUseCase _generateNutritionPlan;
  final AnswerQuestionUseCase _answerQuestion;
  final AnalyzeMealUseCase _analyzeMeal;
  final EvaluateMealUseCase _evaluateMeal;
  final SuggestAlternativesUseCase _suggestAlternatives;

  AiCoachCubit({
    required GenerateWorkoutPlanUseCase generateWorkoutPlan,
    required GenerateNutritionPlanUseCase generateNutritionPlan,
    required AnswerQuestionUseCase answerQuestion,
    required AnalyzeMealUseCase analyzeMeal,
    required EvaluateMealUseCase evaluateMeal,
    required SuggestAlternativesUseCase suggestAlternatives,
  })  : _generateWorkoutPlan = generateWorkoutPlan,
        _generateNutritionPlan = generateNutritionPlan,
        _answerQuestion = answerQuestion,
        _analyzeMeal = analyzeMeal,
        _evaluateMeal = evaluateMeal,
        _suggestAlternatives = suggestAlternatives,
        super(const AiCoachState());

  Future<void> generateWorkoutPlan(CoachInput input) async {
    emit(state.copyWith(status: AiCoachStatus.generating));
    final result = await _generateWorkoutPlan(input);
    if (result is Left<Failure, WorkoutPlan>) {
      emit(state.copyWith(
        status: AiCoachStatus.error,
        errorMessage: result.value.message,
      ));
    } else if (result is Right<Failure, WorkoutPlan>) {
      emit(state.copyWith(
        status: AiCoachStatus.workoutReady,
        workoutPlan: result.value,
      ));
    }
  }

  Future<void> generateNutritionPlan(CoachInput input) async {
    emit(state.copyWith(status: AiCoachStatus.generating));
    final result = await _generateNutritionPlan(input);
    if (result is Left<Failure, NutritionPlan>) {
      emit(state.copyWith(
        status: AiCoachStatus.error,
        errorMessage: result.value.message,
      ));
    } else if (result is Right<Failure, NutritionPlan>) {
      emit(state.copyWith(
        status: AiCoachStatus.nutritionReady,
        nutritionPlan: result.value,
      ));
    }
  }

  Future<void> askQuestion(String question, {CoachInput? context}) async {
    emit(state.copyWith(status: AiCoachStatus.thinking));
    final result = await _answerQuestion(
      question: question,
      context: context,
    );
    if (result is Left<Failure, String>) {
      emit(state.copyWith(
        status: AiCoachStatus.error,
        errorMessage: result.value.message,
      ));
    } else if (result is Right<Failure, String>) {
      emit(state.copyWith(
        status: AiCoachStatus.answerReady,
        chatMessages: [...state.chatMessages, ChatMessage(question: question, answer: result.value)],
      ));
    }
  }

  Future<void> analyzeMeal({
    required String imagePath,
    String? description,
  }) async {
    emit(state.copyWith(status: AiCoachStatus.analyzing));
    final result = await _analyzeMeal(
      imagePath: imagePath,
      description: description,
    );
    if (result is Left<Failure, MealAnalysis>) {
      emit(state.copyWith(
        status: AiCoachStatus.error,
        errorMessage: result.value.message,
      ));
    } else if (result is Right<Failure, MealAnalysis>) {
      emit(state.copyWith(
        status: AiCoachStatus.analysisReady,
        mealAnalysis: result.value,
      ));
    }
  }

  Future<void> evaluateMeal(String mealDescription) async {
    emit(state.copyWith(status: AiCoachStatus.analyzing));
    final result = await _evaluateMeal(mealDescription: mealDescription);
    if (result is Left<Failure, MealAnalysis>) {
      emit(state.copyWith(
        status: AiCoachStatus.error,
        errorMessage: result.value.message,
      ));
    } else if (result is Right<Failure, MealAnalysis>) {
      emit(state.copyWith(
        status: AiCoachStatus.analysisReady,
        mealAnalysis: result.value,
      ));
    }
  }

  Future<void> getAlternatives({
    required String mealDescription,
    required String dietaryPreference,
  }) async {
    emit(state.copyWith(status: AiCoachStatus.thinking));
    final result = await _suggestAlternatives(
      mealDescription: mealDescription,
      dietaryPreference: dietaryPreference,
    );
    if (result is Left<Failure, List<String>>) {
      emit(state.copyWith(
        status: AiCoachStatus.error,
        errorMessage: result.value.message,
      ));
    } else if (result is Right<Failure, List<String>>) {
      emit(state.copyWith(
        status: AiCoachStatus.idle,
        alternatives: result.value,
      ));
    }
  }

  void setInput(CoachInput input) {
    emit(state.copyWith(userInput: input));
  }

  void reset() {
    emit(const AiCoachState());
  }
}

