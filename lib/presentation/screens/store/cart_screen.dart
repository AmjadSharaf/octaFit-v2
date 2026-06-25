import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/widgets/bottom_nav_bar.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/primary_button.dart';
import 'package:octafit/core/widgets/top_bar.dart';
import 'package:octafit/features/marketplace/domain/entities/product_entity.dart';
import 'package:octafit/features/marketplace/presentation/cubit/marketplace_cubit.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MarketplaceCubit, MarketplaceState>(
      builder: (context, state) {
        final cart = state.cart;
        final total = cart.fold<double>(
          0.0,
          (sum, item) => sum + item.subtotal,
        );

        return OctaScreen(
          showOrbs: true,
          safeArea: false,
          body: Column(
            children: [
              const OctaTopBar(title: 'Cart', showBack: true),
              Expanded(
                child: cart.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.shopping_cart_outlined,
                              size: 64,
                              color: AppColors.dimGray,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Your cart is empty',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: AppColors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Browse the store to add items',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: AppColors.gray,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                        itemCount: cart.length,
                        itemBuilder: (context, index) {
                          return _CartItemTile(
                            item: cart[index],
                            onDecrement: () => context
                                .read<MarketplaceCubit>()
                                .updateCartQuantity(
                                  cart[index].product.id,
                                  cart[index].quantity - 1,
                                ),
                            onIncrement: () => context
                                .read<MarketplaceCubit>()
                                .updateCartQuantity(
                                  cart[index].product.id,
                                  cart[index].quantity + 1,
                                ),
                          );
                        },
                      ),
              ),
              if (cart.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                  child: Column(
                    children: [
                      GlassCard(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Text(
                              'Total',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.white,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '\$${total.toStringAsFixed(2)}',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: AppColors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      PrimaryButton(
                        label: 'Checkout',
                        variant: PrimaryButtonVariant.gradient,
                        onPressed: () =>
                            context.push(AppRoutes.checkoutAddress),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _CartItemTile extends StatelessWidget {
  const _CartItemTile({
    required this.item,
    required this.onDecrement,
    required this.onIncrement,
  });

  final CartItemEntity item;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassCard(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Text(item.product.icon, style: const TextStyle(fontSize: 36)),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.name,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
                  Text(
                    '\$${item.product.price.toStringAsFixed(2)} each',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: AppColors.gray,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _QtyBtn(
                      icon: Icons.remove,
                      onTap: onDecrement,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        '${item.quantity}',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    _QtyBtn(
                      icon: Icons.add,
                      onTap: onIncrement,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${item.subtotal.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _QtyBtn extends StatelessWidget {
  const _QtyBtn({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: AppColors.chipInactive,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 16, color: AppColors.white),
      ),
    );
  }
}
