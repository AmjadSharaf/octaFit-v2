import 'package:equatable/equatable.dart';

class MealAnalysis extends Equatable {
  final String mealName;
  final double estimatedCalories;
  final double protein;
  final double carbs;
  final double fat;
  final int qualityScore;
  final List<String> positives;
  final List<String> concerns;
  final List<String> suggestions;

  const MealAnalysis({
    required this.mealName,
    required this.estimatedCalories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.qualityScore,
    required this.positives,
    required this.concerns,
    required this.suggestions,
  });

  @override
  List<Object?> get props => [
        mealName,
        estimatedCalories,
        protein,
        carbs,
        fat,
        qualityScore,
        positives,
        concerns,
        suggestions,
      ];
}
