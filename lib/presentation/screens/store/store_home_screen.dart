import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/widgets/bottom_nav_bar.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/section_header.dart';
import 'package:octafit/features/marketplace/domain/entities/product_entity.dart';
import 'package:octafit/features/marketplace/presentation/cubit/marketplace_cubit.dart';

const storeCategories = ['All', 'Supplements', 'Equipment', 'Apparel'];

class StoreHomeScreen extends StatelessWidget {
  const StoreHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MarketplaceCubit, MarketplaceState>(
      builder: (context, state) {
        if (state.status == MarketplaceStatus.initial) {
          context.read<MarketplaceCubit>().loadProducts();
        }

        final featured = state.products.take(4).toList();
        final cartCount = state.cart.fold<int>(
          0,
          (sum, item) => sum + item.quantity,
        );

        return SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'OctaFit Store',
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                            ),
                          ),
                          Text(
                            'Premium supplements & gear',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: AppColors.gray,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context.push(AppRoutes.cart),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          GlassCard(
                            padding: const EdgeInsets.all(10),
                            borderRadius: 12,
                            child: Icon(
                              Icons.shopping_cart_rounded,
                              color: AppColors.white,
                            ),
                          ),
                          if (cartCount > 0)
                            Positioned(
                              right: -4,
                              top: -4,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: AppColors.blue,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  '$cartCount',
                                  style: GoogleFonts.inter(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const SectionHeader(title: 'Categories'),
                SizedBox(
                  height: 100,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: storeCategories.length - 1,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final cat = storeCategories[index + 1];
                      final icons = {
                        'Supplements': '\u{1F48A}',
                        'Equipment': '\u{1F392}',
                        'Apparel': '\u{1F455}',
                      };
                      return GlassCard(
                        onTap: () => context.push(
                          '${AppRoutes.categoryBrowse}?category=$cat',
                        ),
                        width: 100,
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              icons[cat] ?? '\u{1F4E6}',
                              style: const TextStyle(fontSize: 28),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              cat,
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppColors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SectionHeader(
                  title: 'Featured Products',
                  actionLabel: 'See All',
                  onAction: () => context.push(
                    '${AppRoutes.categoryBrowse}?category=All',
                  ),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.72,
                  ),
                  itemCount: featured.length,
                  itemBuilder: (context, index) {
                    return _ProductCard(
                      product: featured[index],
                      onTap: () => context.push(
                        '${AppRoutes.productDetail}?id=${featured[index].id}',
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product, required this.onTap});

  final ProductEntity product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      onTap: onTap,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(product.icon, style: const TextStyle(fontSize: 40)),
          ),
          const SizedBox(height: 8),
          Text(
            product.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
          Text(
            product.brand,
            style: GoogleFonts.inter(fontSize: 11, color: AppColors.gray),
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
              Icon(Icons.star_rounded, size: 14, color: AppColors.orange),
              Text(
                ' ${product.rating}',
                style: GoogleFonts.inter(fontSize: 11, color: AppColors.gray),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
