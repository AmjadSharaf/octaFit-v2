import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/widgets/bottom_nav_bar.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/primary_button.dart';
import 'package:octafit/core/widgets/section_header.dart';
import 'package:octafit/core/widgets/top_bar.dart';
import 'package:octafit/features/marketplace/presentation/cubit/marketplace_cubit.dart';

class CheckoutReviewScreen extends StatelessWidget {
  const CheckoutReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.white : AppColors.lightText;
    final subColor = isDark ? AppColors.gray : AppColors.lightGray;

    return BlocBuilder<MarketplaceCubit, MarketplaceState>(
      builder: (context, state) {
        final cart = state.cart;
        final total = state.cartTotal;
        return OctaScreen(
          showOrbs: true,
          safeArea: false,
          body: Column(
            children: [
              const OctaTopBar(title: 'Review Order', showBack: true),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _StepIndicator(current: 3),
                      const SectionHeader(title: 'Items'),
                      ...cart.map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: GlassCard(
                            padding: const EdgeInsets.all(14),
                            child: Row(
                              children: [
                                Text(item.product.icon, style: const TextStyle(fontSize: 28)),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.product.name,
                                        style: GoogleFonts.spaceGrotesk(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: textColor,
                                        ),
                                      ),
                                      Text(
                                        'Qty: ${item.quantity}',
                                        style: GoogleFonts.inter(
                                          fontSize: 12,
                                          color: subColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  '\$${item.subtotal.toStringAsFixed(2)}',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SectionHeader(title: 'Shipping'),
                      GlassCard(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.addressFullName ?? '',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: textColor,
                              ),
                            ),
                            Text(
                              state.addressStreet ?? '',
                              style: GoogleFonts.inter(fontSize: 13, color: subColor),
                            ),
                            Text(
                              '${state.addressCity ?? ''}, ${state.addressZip ?? ''}',
                              style: GoogleFonts.inter(fontSize: 13, color: subColor),
                            ),
                            Text(
                              state.addressPhone ?? '',
                              style: GoogleFonts.inter(fontSize: 13, color: subColor),
                            ),
                          ],
                        ),
                      ),
                      const SectionHeader(title: 'Payment'),
                      GlassCard(
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          children: [
                            const Icon(Icons.credit_card_rounded, color: AppColors.blue),
                            const SizedBox(width: 12),
                            Text(
                              '${state.paymentMethod ?? ''} · ${state.paymentCardNumber ?? ''}',
                              style: GoogleFonts.inter(fontSize: 14, color: textColor),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      GlassCard(
                        glow: GlassGlow.blue,
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Text(
                              'Order Total',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: textColor,
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
                      const SizedBox(height: 16),
                      PrimaryButton(
                        label: 'Place Order',
                        variant: PrimaryButtonVariant.gradient,
                        onPressed: () {
                          context.read<MarketplaceCubit>().clearCart();
                          context.go(AppRoutes.orderSuccess);
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

class _StepIndicator extends StatelessWidget {
  const _StepIndicator({required this.current});

  final int current;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: List.generate(3, (i) {
          final step = i + 1;
          final active = step <= current;
          return Expanded(
            child: Container(
              height: 4,
              margin: EdgeInsets.only(right: i < 2 ? 8 : 0),
              decoration: BoxDecoration(
                color: active ? AppColors.blue : AppColors.chipInactive,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }),
      ),
    );
  }
}
