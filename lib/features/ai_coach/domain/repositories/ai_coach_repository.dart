import 'package:octafit/core/errors/failure.dart';
import 'package:octafit/core/utils/either.dart';
import 'package:octafit/features/ai_coach/domain/entities/coach_input.dart';
import 'package:octafit/features/ai_coach/domain/entities/meal_analysis.dart';
import 'package:octafit/features/ai_coach/domain/entities/nutrition_plan.dart';
import 'package:octafit/features/ai_coach/domain/entities/workout_plan.dart';

abstract class AiCoachRepository {
  Future<Either<Failure, WorkoutPlan>> generateWorkoutPlan(
    CoachInput input,
  );

  Future<Either<Failure, NutritionPlan>> generateNutritionPlan(
    CoachInput input,
  );

  Future<Either<Failure, WorkoutPlan>> modifyPlan({
    required String planId,
    required Map<String, dynamic> modifications,
  });

  Future<Either<Failure, String>> answerQuestion({
    required String question,
    CoachInput? context,
  });

  Future<Either<Failure, MealAnalysis>> analyzeMeal({
    required String imagePath,
    String? description,
  });

  Future<Either<Failure, MealAnalysis>> evaluateMeal({
    required String mealDescription,
  });

  Future<Either<Failure, List<String>>> suggestAlternatives({
    required String mealDescription,
    required String dietaryPreference,
  });

  Future<Either<Failure, Map<String, dynamic>>> trackProgress({
    required String planId,
    required Map<String, dynamic> progressData,
  });
}

class MockAiCoachRepository implements AiCoachRepository {
  @override
  Future<Either<Failure, WorkoutPlan>> generateWorkoutPlan(CoachInput input) async {
    return Right(WorkoutPlan(
      id: 'wp1',
      name: 'Personalized ${input.sportType.name} Plan',
      description: 'Tailored ${input.goal.name} plan based on your metrics',
      durationWeeks: 8,
      days: [
        WorkoutDay(day: 1, name: 'Upper Body', exercises: [
          PlannedExercise(name: 'Bench Press', sets: 4, reps: 10, weight: 60, restSeconds: 90),
          PlannedExercise(name: 'Pull Ups', sets: 3, reps: 8, restSeconds: 60),
        ]),
        WorkoutDay(day: 2, name: 'Lower Body', exercises: [
          PlannedExercise(name: 'Squats', sets: 4, reps: 12, weight: 80, restSeconds: 90),
          PlannedExercise(name: 'Deadlifts', sets: 3, reps: 8, weight: 100, restSeconds: 120),
        ]),
      ],
      intensity: 'Moderate',
      focus: input.goal.name,
    ));
  }

  @override
  Future<Either<Failure, NutritionPlan>> generateNutritionPlan(CoachInput input) async {
    return Right(NutritionPlan(
      id: 'np1',
      dailyCalories: 2200,
      proteinGrams: 150,
      carbsGrams: 250,
      fatGrams: 65,
      meals: [
        MealPlan(name: 'Breakfast', time: '07:00', calories: 500, protein: 35, carbs: 60, fat: 12, foods: ['Oats', 'Protein shake', 'Banana']),
        MealPlan(name: 'Lunch', time: '12:30', calories: 700, protein: 45, carbs: 80, fat: 20, foods: ['Chicken breast', 'Brown rice', 'Broccoli']),
      ],
      notes: 'Drink at least 3L of water daily',
    ));
  }

  @override
  Future<Either<Failure, WorkoutPlan>> modifyPlan({required String planId, required Map<String, dynamic> modifications}) async {
    return Right(WorkoutPlan(
      id: planId, name: 'Modified Plan', description: 'Updated version', durationWeeks: 8,
      days: [], intensity: 'High', focus: 'strength',
    ));
  }

  @override
  Future<Either<Failure, String>> answerQuestion({required String question, CoachInput? context}) async {
    return Right('Based on your profile, I recommend focusing on compound movements and progressive overload. Start with 3-4 sets of 8-12 reps at 70-80% of your 1RM.');
  }

  @override
  Future<Either<Failure, MealAnalysis>> analyzeMeal({required String imagePath, String? description}) async {
    return Right(MealAnalysis(
      mealName: 'Analyzed Meal',
      estimatedCalories: 650,
      protein: 35,
      carbs: 55,
      fat: 28,
      qualityScore: 7,
      positives: ['Good protein content', 'Complex carbs present'],
      concerns: ['High saturated fat'],
      suggestions: ['Add more vegetables', 'Consider leaner protein source'],
    ));
  }

  @override
  Future<Either<Failure, MealAnalysis>> evaluateMeal({required String mealDescription}) async {
    return Right(MealAnalysis(
      mealName: mealDescription,
      estimatedCalories: 500,
      protein: 25, carbs: 50, fat: 20,
      qualityScore: 6,
      positives: ['Balanced macros'],
      concerns: ['Could use more fiber'],
      suggestions: ['Add a side of vegetables'],
    ));
  }

  @override
  Future<Either<Failure, List<String>>> suggestAlternatives({required String mealDescription, required String dietaryPreference}) async {
    return Right(['Grilled chicken salad', 'Quinoa bowl with vegetables', 'Greek yogurt with berries']);
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> trackProgress({required String planId, required Map<String, dynamic> progressData}) async {
    return Right({'status': 'tracked', 'progress': 0.75});
  }
}



