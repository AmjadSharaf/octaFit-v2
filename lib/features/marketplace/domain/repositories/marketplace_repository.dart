import 'package:octafit/core/utils/either.dart';
import 'package:octafit/core/errors/failure.dart';
import 'package:octafit/features/marketplace/domain/entities/product_entity.dart';

abstract class MarketplaceRepository {
  Future<Either<Failure, List<ProductEntity>>> getProducts({
    String? category,
    String? search,
    int page = 1,
    int perPage = 20,
  });

  Future<Either<Failure, ProductEntity>> getProductById(String id);

  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(
    String category, {
    int page = 1,
  });

  Future<Either<Failure, List<ProductEntity>>> searchProducts(String query);

  Future<Either<Failure, List<CartItemEntity>>> getCart();

  Future<Either<Failure, void>> addToCart({
    required String productId,
    int quantity = 1,
  });

  Future<Either<Failure, void>> removeFromCart(String cartItemId);

  Future<Either<Failure, void>> updateCartItemQuantity({
    required String cartItemId,
    required int quantity,
  });

  Future<Either<Failure, void>> clearCart();

  Future<Either<Failure, void>> addToWishlist(String productId);

  Future<Either<Failure, void>> removeFromWishlist(String productId);

  Future<Either<Failure, List<ProductEntity>>> getWishlist();

  Future<Either<Failure, void>> submitReview({
    required String productId,
    required double rating,
    required String comment,
  });

  Future<Either<Failure, List<ReviewEntity>>> getReviews(String productId);
}

class MockMarketplaceRepository implements MarketplaceRepository {
  final List<ProductEntity> _mockProducts = [
    ProductEntity(id: '1', name: 'Premium Gym Gloves', brand: 'OctaFit', price: 29.99, rating: 4.5, reviews: 128, icon: '🧤', category: 'accessories', inStock: true, stockQuantity: 50),
    ProductEntity(id: '2', name: 'Resistance Bands Set', brand: 'OctaFit', price: 19.99, originalPrice: 29.99, rating: 4.8, reviews: 256, icon: '🏋️', category: 'equipment', tag: 'Sale', inStock: true, stockQuantity: 100),
    ProductEntity(id: '3', name: 'MMA Gloves', brand: 'FightPro', price: 49.99, rating: 4.6, reviews: 89, icon: '🥊', category: 'boxing', inStock: true, stockQuantity: 30),
    ProductEntity(id: '4', name: 'Protein Powder 2kg', brand: 'OctaFit', price: 54.99, rating: 4.7, reviews: 512, icon: '💪', category: 'supplements', tag: 'Popular', inStock: true),
    ProductEntity(id: '5', name: 'Yoga Mat Premium', brand: 'FlexFit', price: 39.99, originalPrice: 49.99, rating: 4.4, reviews: 67, icon: '🧘', category: 'equipment', tag: 'Sale', inStock: true),
  ];

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts({String? category, String? search, int page = 1, int perPage = 20}) async {
    var result = _mockProducts;
    if (category != null) result = result.where((p) => p.category == category).toList();
    if (search != null) result = result.where((p) => p.name.toLowerCase().contains(search.toLowerCase())).toList();
    return Right(result);
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductById(String id) async {
    final product = _mockProducts.firstWhere((p) => p.id == id);
    return Right(product);
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(String category, {int page = 1}) async {
    return Right(_mockProducts.where((p) => p.category == category).toList());
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> searchProducts(String query) async {
    return Right(_mockProducts.where((p) => p.name.toLowerCase().contains(query.toLowerCase())).toList());
  }

  @override
  Future<Either<Failure, List<CartItemEntity>>> getCart() async => Right([]);

  @override
  Future<Either<Failure, void>> addToCart({required String productId, int quantity = 1}) async => const Right(null);

  @override
  Future<Either<Failure, void>> removeFromCart(String cartItemId) async => const Right(null);

  @override
  Future<Either<Failure, void>> updateCartItemQuantity({required String cartItemId, required int quantity}) async => const Right(null);

  @override
  Future<Either<Failure, void>> clearCart() async => const Right(null);

  @override
  Future<Either<Failure, void>> addToWishlist(String productId) async => const Right(null);

  @override
  Future<Either<Failure, void>> removeFromWishlist(String productId) async => const Right(null);

  @override
  Future<Either<Failure, List<ProductEntity>>> getWishlist() async => Right(_mockProducts.take(2).toList());

  @override
  Future<Either<Failure, void>> submitReview({required String productId, required double rating, required String comment}) async => const Right(null);

  @override
  Future<Either<Failure, List<ReviewEntity>>> getReviews(String productId) async => Right([]);
}



