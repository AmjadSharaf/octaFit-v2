import 'package:equatable/equatable.dart';

class ShoppingRecommendation extends Equatable {
  final String productId;
  final String productName;
  final double relevanceScore;
  final String reason;

  const ShoppingRecommendation({
    required this.productId,
    required this.productName,
    required this.relevanceScore,
    required this.reason,
  });

  @override
  List<Object?> get props =>
      [productId, productName, relevanceScore, reason];
}

class ShoppingQuery extends Equatable {
  final String? sportType;
  final String? goal;
  final String? bodyType;
  final double? budget;
  final List<String>? preferences;

  const ShoppingQuery({
    this.sportType,
    this.goal,
    this.bodyType,
    this.budget,
    this.preferences,
  });

  @override
  List<Object?> get props => [sportType, goal, bodyType, budget, preferences];
}

class EquipmentRecommendation extends Equatable {
  final String category;
  final String name;
  final String description;
  final String skillLevel;
  final List<ShoppingRecommendation> recommendations;

  const EquipmentRecommendation({
    required this.category,
    required this.name,
    required this.description,
    required this.skillLevel,
    required this.recommendations,
  });

  @override
  List<Object?> get props => [
        category,
        name,
        description,
        skillLevel,
        recommendations,
      ];
}

class SupplementRecommendation extends Equatable {
  final String name;
  final String purpose;
  final String dosage;
  final String timing;
  final String? sideEffects;
  final List<ShoppingRecommendation> recommendations;

  const SupplementRecommendation({
    required this.name,
    required this.purpose,
    required this.dosage,
    required this.timing,
    this.sideEffects,
    required this.recommendations,
  });

  @override
  List<Object?> get props => [
        name,
        purpose,
        dosage,
        timing,
        sideEffects,
        recommendations,
      ];
}
