import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:octafit/core/errors/failure.dart';
import 'package:octafit/core/utils/either.dart';
import 'package:octafit/features/marketplace/domain/entities/product_entity.dart';
import 'package:octafit/features/marketplace/domain/repositories/marketplace_repository.dart';

part 'marketplace_state.dart';

enum ProductSort { popular, priceLow, priceHigh, rating }

class MarketplaceCubit extends Cubit<MarketplaceState> {
  final MarketplaceRepository _repository;

  MarketplaceCubit({required MarketplaceRepository repository})
      : _repository = repository,
        super(const MarketplaceState());

  Future<void> loadProducts() async {
    emit(state.copyWith(status: MarketplaceStatus.loading));
    final result = await _repository.getProducts(
      category: state.selectedCategory,
      search: state.searchQuery,
      page: state.page,
    );
    if (result is Left<Failure, List<ProductEntity>>) {
      emit(state.copyWith(
        status: MarketplaceStatus.error,
        errorMessage: result.value.message,
      ));
    } else if (result is Right<Failure, List<ProductEntity>>) {
      emit(state.copyWith(
        status: MarketplaceStatus.loaded,
        products: result.value,
      ));
    }
  }

  Future<void> setCategory(String category) async {
    emit(state.copyWith(selectedCategory: category, page: 1));
    await loadProducts();
  }

  Future<void> search(String query) async {
    emit(state.copyWith(searchQuery: query, page: 1));
    await loadProducts();
  }

  void setSort(ProductSort sort) {
    emit(state.copyWith(sort: sort));
  }

  List<ProductEntity> get sortedProducts {
    final sorted = List<ProductEntity>.from(state.products);
    switch (state.sort) {
      case ProductSort.popular:
        sorted.sort((a, b) => b.reviews.compareTo(a.reviews));
      case ProductSort.priceLow:
        sorted.sort((a, b) => a.price.compareTo(b.price));
      case ProductSort.priceHigh:
        sorted.sort((a, b) => b.price.compareTo(a.price));
      case ProductSort.rating:
        sorted.sort((a, b) => b.rating.compareTo(a.rating));
    }
    return sorted;
  }

  List<ProductEntity> get productsByCategory {
    if (state.selectedCategory == 'All') return state.products;
    return state.products
        .where((p) => p.category == state.selectedCategory)
        .toList();
  }

  List<ProductEntity> get wishlistProducts {
    return state.products
        .where((p) => state.wishlistIds.contains(p.id))
        .toList();
  }

  void setProducts(List<ProductEntity> products) {
    emit(state.copyWith(
      status: MarketplaceStatus.loaded,
      products: products,
    ));
  }

  Future<void> addToCart(CartItemEntity item) async {
    await _repository.addToCart(productId: item.product.id, quantity: item.quantity);
    final existingIndex = state.cart.indexWhere(
      (i) => i.product.id == item.product.id,
    );
    if (existingIndex >= 0) {
      final updated = [...state.cart];
      final existing = updated[existingIndex];
      updated[existingIndex] = existing.copyWith(
        quantity: existing.quantity + item.quantity,
      );
      emit(state.copyWith(cart: updated));
    } else {
      emit(state.copyWith(cart: [...state.cart, item]));
    }
  }

  Future<void> removeFromCart(String productId) async {
    final item = state.cart.firstWhere((i) => i.product.id == productId);
    await _repository.removeFromCart(item.id);
    emit(state.copyWith(
      cart: state.cart.where((i) => i.product.id != productId).toList(),
    ));
  }

  Future<void> updateCartQuantity(String productId, int quantity) async {
    if (quantity <= 0) {
      await removeFromCart(productId);
      return;
    }
    final item = state.cart.firstWhere((i) => i.product.id == productId);
    await _repository.updateCartItemQuantity(cartItemId: item.id, quantity: quantity);
    emit(state.copyWith(
      cart: state.cart.map((i) {
        if (i.product.id == productId) return i.copyWith(quantity: quantity);
        return i;
      }).toList(),
    ));
  }

  Future<void> clearCart() async {
    await _repository.clearCart();
    emit(state.copyWith(cart: const []));
  }

  Future<void> toggleWishlist(String productId) async {
    final isFav = state.wishlistIds.contains(productId);
    if (isFav) {
      await _repository.removeFromWishlist(productId);
      emit(state.copyWith(
        wishlistIds: state.wishlistIds.where((id) => id != productId).toList(),
      ));
    } else {
      await _repository.addToWishlist(productId);
      emit(state.copyWith(
        wishlistIds: [...state.wishlistIds, productId],
      ));
    }
  }

  void updateAddress({
    String? fullName,
    String? street,
    String? city,
    String? zip,
    String? phone,
  }) {
    emit(state.copyWith(
      addressFullName: fullName,
      addressStreet: street,
      addressCity: city,
      addressZip: zip,
      addressPhone: phone,
    ));
  }

  void updatePayment({
    String? cardNumber,
    String? expiry,
    String? cvv,
    String? method,
  }) {
    emit(state.copyWith(
      paymentCardNumber: cardNumber,
      paymentExpiry: expiry,
      paymentCvv: cvv,
      paymentMethod: method,
    ));
  }

  void reset() {
    emit(const MarketplaceState());
  }
}
