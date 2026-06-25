import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/routing/app_routes.dart';
import 'package:octafit/core/widgets/chip_widget.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/top_bar.dart';
import 'package:octafit/features/marketplace/domain/entities/product_entity.dart';
import 'package:octafit/features/marketplace/presentation/cubit/marketplace_cubit.dart';

class CategoryBrowseScreen extends StatefulWidget {
  const CategoryBrowseScreen({super.key, required this.category});

  final String category;

  @override
  State<CategoryBrowseScreen> createState() => _CategoryBrowseScreenState();
}

class _CategoryBrowseScreenState extends State<CategoryBrowseScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MarketplaceCubit>().setCategory(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MarketplaceCubit, MarketplaceState>(
      builder: (context, state) {
        final cubit = context.read<MarketplaceCubit>();
        final filtered = cubit.productsByCategory;
        final products = List<ProductEntity>.from(filtered);
        products.sort((a, b) {
          switch (state.sort) {
            case ProductSort.popular:
              return b.reviews.compareTo(a.reviews);
            case ProductSort.priceLow:
              return a.price.compareTo(b.price);
            case ProductSort.priceHigh:
              return b.price.compareTo(a.price);
            case ProductSort.rating:
              return b.rating.compareTo(a.rating);
          }
        });
        final sort = state.sort;
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final textColor = isDark ? AppColors.white : AppColors.lightText;
        final subColor = isDark ? AppColors.gray : AppColors.lightGray;

        return OctaScreen(
          showOrbs: true,
          safeArea: false,
          body: Column(
            children: [
              OctaTopBar(title: widget.category == 'All' ? 'All Products' : widget.category, showBack: true),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ChipWidget(
                        label: 'Popular',
                        active: sort == ProductSort.popular,
                        onTap: () => context
                            .read<MarketplaceCubit>()
                            .setSort(ProductSort.popular),
                      ),
                      const SizedBox(width: 8),
                      ChipWidget(
                        label: 'Price ↑',
                        active: sort == ProductSort.priceLow,
                        onTap: () => context
                            .read<MarketplaceCubit>()
                            .setSort(ProductSort.priceLow),
                      ),
                      const SizedBox(width: 8),
                      ChipWidget(
                        label: 'Price ↓',
                        active: sort == ProductSort.priceHigh,
                        onTap: () => context
                            .read<MarketplaceCubit>()
                            .setSort(ProductSort.priceHigh),
                      ),
                      const SizedBox(width: 8),
                      ChipWidget(
                        label: 'Rating',
                        active: sort == ProductSort.rating,
                        onTap: () => context
                            .read<MarketplaceCubit>()
                            .setSort(ProductSort.rating),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.72,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return _ProductGridItem(
                      product: product,
                      textColor: textColor,
                      subColor: subColor,
                      onTap: () => context.push(
                        '${AppRoutes.productDetail}?id=${product.id}',
                      ),
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

class _ProductGridItem extends StatelessWidget {
  const _ProductGridItem({
    required this.product,
    required this.textColor,
    required this.subColor,
    required this.onTap,
  });

  final ProductEntity product;
  final Color textColor;
  final Color subColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      onTap: onTap,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Text(product.icon, style: const TextStyle(fontSize: 40))),
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
          Text(
            '\$${product.price.toStringAsFixed(0)}',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
