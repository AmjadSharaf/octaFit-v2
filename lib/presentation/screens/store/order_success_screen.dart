import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/widgets/bottom_nav_bar.dart';
import 'package:octafit/core/widgets/ghost_button.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/primary_button.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.white : AppColors.lightText;
    final subColor = isDark ? AppColors.gray : AppColors.lightGray;
    final orderId = 'OCT-${DateTime.now().millisecondsSinceEpoch % 100000}';

    return OctaScreen(
      showOrbs: true,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.gradGreenCyan,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.green.withValues(alpha: 0.3),
                      blurRadius: 30,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.check_rounded,
                  size: 52,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Order Placed!',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Thank you for your purchase',
                style: GoogleFonts.inter(fontSize: 14, color: subColor),
              ),
              const SizedBox(height: 24),
              GlassCard(
                glow: GlassGlow.blue,
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'Order #$orderId',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Estimated delivery: 3-5 business days',
                      style: GoogleFonts.inter(fontSize: 13, color: subColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              PrimaryButton(
                label: 'Continue Shopping',
                onPressed: () => context.go(AppRoutes.store),
              ),
              const SizedBox(height: 12),
              GhostButton(
                label: 'Back to Home',
                onPressed: () => context.go(AppRoutes.home),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
