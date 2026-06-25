part of 'marketplace_cubit.dart';

enum MarketplaceStatus {
  initial,
  loading,
  loaded,
  error,
}

class MarketplaceState extends Equatable {
  final MarketplaceStatus status;
  final List<ProductEntity> products;
  final List<CartItemEntity> cart;
  final List<String> wishlistIds;
  final String selectedCategory;
  final String searchQuery;
  final int page;
  final bool hasMore;
  final ProductSort sort;
  final String? addressFullName;
  final String? addressStreet;
  final String? addressCity;
  final String? addressZip;
  final String? addressPhone;
  final String? paymentCardNumber;
  final String? paymentExpiry;
  final String? paymentCvv;
  final String? paymentMethod;
  final String? errorMessage;

  const MarketplaceState({
    this.status = MarketplaceStatus.initial,
    this.products = const [],
    this.cart = const [],
    this.wishlistIds = const [],
    this.selectedCategory = 'All',
    this.searchQuery = '',
    this.page = 1,
    this.hasMore = true,
    this.sort = ProductSort.popular,
    this.addressFullName = 'Alex Johnson',
    this.addressStreet = '42 Fitness Ave, Apt 12',
    this.addressCity = 'San Francisco',
    this.addressZip = '94102',
    this.addressPhone = '+1 (555) 012-3456',
    this.paymentCardNumber = '\u2022\u2022\u2022\u2022 \u2022\u2022\u2022\u2022 \u2022\u2022\u2022\u2022 4242',
    this.paymentExpiry = '12/28',
    this.paymentCvv = '\u2022\u2022\u2022',
    this.paymentMethod = 'Visa',
    this.errorMessage,
  });

  bool get isLoading => status == MarketplaceStatus.loading;
  int get cartCount => cart.fold(0, (sum, item) => sum + item.quantity);
  double get cartTotal => cart.fold(0.0, (sum, item) => sum + item.subtotal);

  MarketplaceState copyWith({
    MarketplaceStatus? status,
    List<ProductEntity>? products,
    List<CartItemEntity>? cart,
    List<String>? wishlistIds,
    String? selectedCategory,
    String? searchQuery,
    int? page,
    bool? hasMore,
    ProductSort? sort,
    String? addressFullName,
    String? addressStreet,
    String? addressCity,
    String? addressZip,
    String? addressPhone,
    String? paymentCardNumber,
    String? paymentExpiry,
    String? paymentCvv,
    String? paymentMethod,
    String? errorMessage,
    bool clearError = false,
  }) {
    return MarketplaceState(
      status: status ?? this.status,
      products: products ?? this.products,
      cart: cart ?? this.cart,
      wishlistIds: wishlistIds ?? this.wishlistIds,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      sort: sort ?? this.sort,
      addressFullName: addressFullName ?? this.addressFullName,
      addressStreet: addressStreet ?? this.addressStreet,
      addressCity: addressCity ?? this.addressCity,
      addressZip: addressZip ?? this.addressZip,
      addressPhone: addressPhone ?? this.addressPhone,
      paymentCardNumber: paymentCardNumber ?? this.paymentCardNumber,
      paymentExpiry: paymentExpiry ?? this.paymentExpiry,
      paymentCvv: paymentCvv ?? this.paymentCvv,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
        status,
        products,
        cart,
        wishlistIds,
        selectedCategory,
        searchQuery,
        page,
        hasMore,
        sort,
        addressFullName,
        addressStreet,
        addressCity,
        addressZip,
        addressPhone,
        paymentCardNumber,
        paymentExpiry,
        paymentCvv,
        paymentMethod,
        errorMessage,
      ];
}
