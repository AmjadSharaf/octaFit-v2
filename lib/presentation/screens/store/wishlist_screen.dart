import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/routing/app_routes.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/top_bar.dart';
import 'package:octafit/features/marketplace/domain/entities/product_entity.dart';
import 'package:octafit/features/marketplace/presentation/cubit/marketplace_cubit.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MarketplaceCubit, MarketplaceState>(
      builder: (context, state) {
        final cubit = context.read<MarketplaceCubit>();
        final wishlistProducts = cubit.wishlistProducts;
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final textColor = isDark ? AppColors.white : AppColors.lightText;
        final subColor = isDark ? AppColors.gray : AppColors.lightGray;

        return OctaScreen(
          showOrbs: true,
          safeArea: false,
          body: Column(
            children: [
              OctaTopBar(
                title: 'Wishlist',
                subtitle: '${wishlistProducts.length} saved items',
                showBack: true,
              ),
              Expanded(
                child: wishlistProducts.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.favorite_border_rounded,
                                size: 48,
                                color: subColor,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Your wishlist is empty',
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: textColor,
                                ),
                              ),
                              Text(
                                'Save products you love for later',
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  color: subColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.72,
                        ),
                        itemCount: wishlistProducts.length,
                        itemBuilder: (context, index) {
                          final product = wishlistProducts[index];
                          return _WishlistProductCard(
                            product: product,
                            textColor: textColor,
                            subColor: subColor,
                            onTap: () => context.push(
                              '${AppRoutes.productDetail}?id=${product.id}',
                            ),
                            onRemove: () => context
                                .read<MarketplaceCubit>()
                                .toggleWishlist(product.id),
                            onAddToCart: () {
                              context.read<MarketplaceCubit>().addToCart(
                                CartItemEntity(
                                  id: product.id,
                                  product: product,
                                  quantity: 1,
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${product.name} added to cart',
                                    style: GoogleFonts.inter(),
                                  ),
                                  backgroundColor: AppColors.blue,
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _WishlistProductCard extends StatelessWidget {
  const _WishlistProductCard({
    required this.product,
    required this.textColor,
    required this.subColor,
    required this.onTap,
    required this.onRemove,
    required this.onAddToCart,
  });

  final ProductEntity product;
  final Color textColor;
  final Color subColor;
  final VoidCallback onTap;
  final VoidCallback onRemove;
  final VoidCallback onAddToCart;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      onTap: onTap,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(product.icon, style: const TextStyle(fontSize: 36)),
              GestureDetector(
                onTap: onRemove,
                child: const Icon(
                  Icons.favorite_rounded,
                  color: AppColors.red,
                  size: 22,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            product.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
          Text(
            product.brand,
            style: GoogleFonts.inter(fontSize: 11, color: subColor),
          ),
          const Spacer(),
          Row(
            children: [
              Text(
                '\$${product.price.toStringAsFixed(0)}',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.blue,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: onAddToCart,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.chipInactive,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.add_shopping_cart_rounded,
                    size: 18,
                    color: AppColors.blue,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

