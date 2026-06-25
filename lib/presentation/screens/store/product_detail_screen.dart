import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/widgets/badge_widget.dart';
import 'package:octafit/core/widgets/chip_widget.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/primary_button.dart';
import 'package:octafit/core/widgets/top_bar.dart';
import 'package:octafit/features/marketplace/domain/entities/product_entity.dart';
import 'package:octafit/features/marketplace/presentation/cubit/marketplace_cubit.dart';

const _productFlavors = ['Chocolate', 'Vanilla', 'Strawberry', 'Unflavored'];

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.productId});

  final String productId;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;
  late String _selectedFlavor;

  @override
  void initState() {
    super.initState();
    _selectedFlavor = _productFlavors.first;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MarketplaceCubit, MarketplaceState>(
      builder: (context, state) {
        if (state.status == MarketplaceStatus.initial) {
          context.read<MarketplaceCubit>().loadProducts();
        }

        final product = state.products.cast<ProductEntity?>().firstWhere(
          (p) => p?.id == widget.productId,
          orElse: () => null,
        );

        if (product == null) {
          return OctaScreen(
            showOrbs: true,
            body: const Center(child: Text('Product not found')),
          );
        }

        final isDark = Theme.of(context).brightness == Brightness.dark;
        final textColor = isDark ? AppColors.white : AppColors.lightText;
        final subColor = isDark ? AppColors.gray : AppColors.lightGray;

        return OctaScreen(
          showOrbs: true,
          safeArea: false,
          body: Column(
            children: [
              const OctaTopBar(title: 'Product', showBack: true),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GlassCard(
                        glow: GlassGlow.blue,
                        padding: const EdgeInsets.all(32),
                        child: Center(
                          child: Text(product.icon, style: const TextStyle(fontSize: 72)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (product.tag != null) ...[
                        BadgeWidget(label: product.tag!, color: BadgeColor.purple),
                        const SizedBox(height: 8),
                      ],
                      Text(
                        product.name,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: textColor,
                        ),
                      ),
                      Text(
                        product.brand,
                        style: GoogleFonts.inter(fontSize: 14, color: subColor),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: AppColors.blue,
                            ),
                          ),
                          const Spacer(),
                          const Icon(Icons.star_rounded, color: AppColors.orange, size: 20),
                          Text(
                            ' ${product.rating} (${product.reviews})',
                            style: GoogleFonts.inter(fontSize: 13, color: subColor),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Flavor',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _productFlavors.map((f) {
                          return ChipWidget(
                            label: f,
                            active: _selectedFlavor == f,
                            onTap: () => setState(() => _selectedFlavor = f),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Quantity',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      GlassCard(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: _quantity > 1
                                  ? () => setState(() => _quantity--)
                                  : null,
                              icon: const Icon(Icons.remove_rounded),
                              color: textColor,
                            ),
                            Text(
                              '$_quantity',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: textColor,
                              ),
                            ),
                            IconButton(
                              onPressed: () => setState(() => _quantity++),
                              icon: const Icon(Icons.add_rounded),
                              color: textColor,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      PrimaryButton(
                        label: 'Add to Cart — \$${(product.price * _quantity).toStringAsFixed(2)}',
                        variant: PrimaryButtonVariant.gradient,
                        icon: const Icon(Icons.shopping_cart_rounded, color: AppColors.white, size: 20),
                        onPressed: () {
                          context.read<MarketplaceCubit>().addToCart(
                            CartItemEntity(
                              id: widget.productId,
                              product: product,
                              quantity: _quantity,
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${product.name} added to cart')),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
