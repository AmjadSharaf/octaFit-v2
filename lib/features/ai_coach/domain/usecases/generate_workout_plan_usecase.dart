import 'package:octafit/core/utils/either.dart';
import 'package:octafit/core/errors/failure.dart';
import 'package:octafit/features/ai_coach/domain/entities/coach_input.dart';
import 'package:octafit/features/ai_coach/domain/entities/meal_analysis.dart';
import 'package:octafit/features/ai_coach/domain/entities/nutrition_plan.dart';
import 'package:octafit/features/ai_coach/domain/entities/workout_plan.dart';
import 'package:octafit/features/ai_coach/domain/repositories/ai_coach_repository.dart';

class GenerateWorkoutPlanUseCase {
  final AiCoachRepository _repository;

  GenerateWorkoutPlanUseCase(this._repository);

  Future<Either<Failure, WorkoutPlan>> call(CoachInput input) {
    return _repository.generateWorkoutPlan(input);
  }
}

class GenerateNutritionPlanUseCase {
  final AiCoachRepository _repository;

  GenerateNutritionPlanUseCase(this._repository);

  Future<Either<Failure, NutritionPlan>> call(CoachInput input) {
    return _repository.generateNutritionPlan(input);
  }
}

class ModifyPlanUseCase {
  final AiCoachRepository _repository;

  ModifyPlanUseCase(this._repository);

  Future<Either<Failure, WorkoutPlan>> call({
    required String planId,
    required Map<String, dynamic> modifications,
  }) {
    return _repository.modifyPlan(planId: planId, modifications: modifications);
  }
}

class AnswerQuestionUseCase {
  final AiCoachRepository _repository;

  AnswerQuestionUseCase(this._repository);

  Future<Either<Failure, String>> call({
    required String question,
    CoachInput? context,
  }) {
    return _repository.answerQuestion(question: question, context: context);
  }
}

class AnalyzeMealUseCase {
  final AiCoachRepository _repository;

  AnalyzeMealUseCase(this._repository);

  Future<Either<Failure, MealAnalysis>> call({
    required String imagePath,
    String? description,
  }) {
    return _repository.analyzeMeal(imagePath: imagePath, description: description);
  }
}

class EvaluateMealUseCase {
  final AiCoachRepository _repository;

  EvaluateMealUseCase(this._repository);

  Future<Either<Failure, MealAnalysis>> call({
    required String mealDescription,
  }) {
    return _repository.evaluateMeal(mealDescription: mealDescription);
  }
}

class SuggestAlternativesUseCase {
  final AiCoachRepository _repository;

  SuggestAlternativesUseCase(this._repository);

  Future<Either<Failure, List<String>>> call({
    required String mealDescription,
    required String dietaryPreference,
  }) {
    return _repository.suggestAlternatives(
      mealDescription: mealDescription,
      dietaryPreference: dietaryPreference,
    );
  }
}


