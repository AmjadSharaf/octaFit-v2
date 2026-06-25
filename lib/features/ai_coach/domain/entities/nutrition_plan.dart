import 'package:equatable/equatable.dart';

class NutritionPlan extends Equatable {
  final String id;
  final double dailyCalories;
  final double proteinGrams;
  final double carbsGrams;
  final double fatGrams;
  final List<MealPlan> meals;
  final String? notes;

  const NutritionPlan({
    required this.id,
    required this.dailyCalories,
    required this.proteinGrams,
    required this.carbsGrams,
    required this.fatGrams,
    required this.meals,
    this.notes,
  });

  @override
  List<Object?> get props => [
        id,
        dailyCalories,
        proteinGrams,
        carbsGrams,
        fatGrams,
        meals,
        notes,
      ];
}

class MealPlan extends Equatable {
  final String name;
  final String time;
  final double calories;
  final double protein;
  final double carbs;
  final double fat;
  final List<String> foods;
  final String? recipe;

  const MealPlan({
    required this.name,
    required this.time,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.foods,
    this.recipe,
  });

  @override
  List<Object?> get props => [
        name,
        time,
        calories,
        protein,
        carbs,
        fat,
        foods,
        recipe,
      ];
}
