import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String id;
  final String name;
  final String brand;
  final double price;
  final double? originalPrice;
  final double rating;
  final int reviews;
  final String icon;
  final String category;
  final String? tag;
  final List<String>? images;
  final String? description;
  final bool inStock;
  final int? stockQuantity;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    this.originalPrice,
    required this.rating,
    required this.reviews,
    required this.icon,
    required this.category,
    this.tag,
    this.images,
    this.description,
    this.inStock = true,
    this.stockQuantity,
  });

  ProductEntity copyWith({
    String? id,
    String? name,
    String? brand,
    double? price,
    double? originalPrice,
    double? rating,
    int? reviews,
    String? icon,
    String? category,
    String? tag,
    List<String>? images,
    String? description,
    bool? inStock,
    int? stockQuantity,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      rating: rating ?? this.rating,
      reviews: reviews ?? this.reviews,
      icon: icon ?? this.icon,
      category: category ?? this.category,
      tag: tag ?? this.tag,
      images: images ?? this.images,
      description: description ?? this.description,
      inStock: inStock ?? this.inStock,
      stockQuantity: stockQuantity ?? this.stockQuantity,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        brand,
        price,
        originalPrice,
        rating,
        reviews,
        icon,
        category,
        tag,
        images,
        description,
        inStock,
        stockQuantity,
      ];
}

class CartItemEntity extends Equatable {
  final String id;
  final ProductEntity product;
  final int quantity;

  const CartItemEntity({
    required this.id,
    required this.product,
    required this.quantity,
  });

  double get subtotal => product.price * quantity;

  CartItemEntity copyWith({
    String? id,
    ProductEntity? product,
    int? quantity,
  }) {
    return CartItemEntity(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [id, product, quantity];
}

class ReviewEntity extends Equatable {
  final String id;
  final String userId;
  final String userName;
  final double rating;
  final String comment;
  final DateTime date;

  const ReviewEntity({
    required this.id,
    required this.userId,
    required this.userName,
    required this.rating,
    required this.comment,
    required this.date,
  });

  @override
  List<Object?> get props =>
      [id, userId, userName, rating, comment, date];
}
