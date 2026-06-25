import 'package:octafit/core/utils/either.dart';
import 'package:octafit/core/errors/failure.dart';
import 'package:octafit/features/ai_shopping_assistant/domain/entities/shopping_recommendation.dart';

abstract class ShoppingAssistantRepository {
  Future<Either<Failure, List<ShoppingRecommendation>>> getRecommendations({
    required ShoppingQuery query,
  });

  Future<Either<Failure, List<EquipmentRecommendation>>> getEquipmentRecommendations({
    required String sportType,
    required String skillLevel,
  });

  Future<Either<Failure, List<SupplementRecommendation>>> getSupplementRecommendations({
    required String goal,
    required String dietType,
  });

  Future<Either<Failure, List<ShoppingRecommendation>>> getPersonalizedSuggestions({
    required String userId,
  });
}


