import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/routing/app_routes.dart';
import 'package:octafit/core/widgets/badge_widget.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/ghost_button.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/primary_button.dart';
import 'package:octafit/core/widgets/top_bar.dart';

class SubscriptionPaywallScreen extends StatefulWidget {
  const SubscriptionPaywallScreen({super.key});

  @override
  State<SubscriptionPaywallScreen> createState() =>
      _SubscriptionPaywallScreenState();

  static const _proFeatures = [
    ('🤖', 'Unlimited AI Coach sessions'),
    ('📹', 'Advanced motion analysis'),
    ('📊', 'Detailed analytics & insights'),
    ('🏋️', 'All premium training programs'),
    ('🎯', 'Personalized meal plans'),
    ('👥', 'Priority community support'),
    ('🥊', 'MMA & fight camp programs'),
    ('📈', 'Digital athlete predictions'),
  ];

}

class _SubscriptionPaywallScreenState
    extends State<SubscriptionPaywallScreen> {
  String _selectedPlan = 'monthly';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.white : AppColors.lightText;
    final subColor = isDark ? AppColors.gray : AppColors.lightGray;

    return OctaScreen(
      showOrbs: true,
      safeArea: false,
      body: Column(
        children: [
          const OctaTopBar(title: 'Go Pro', showBack: true),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: Column(
                children: [
                  GlassCard(
                    glow: GlassGlow.purple,
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        const BadgeWidget(
                          label: 'OCTAFIT PRO',
                          color: BadgeColor.purple,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Unlock Your Full Potential',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'AI coaching, premium programs & advanced analytics',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: subColor,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: _PlanCard(
                          label: 'Monthly',
                          price: '\$14.99',
                          period: '/month',
                          selected: _selectedPlan == 'monthly',
                          textColor: textColor,
                          subColor: subColor,
                          onTap: () =>
                              setState(() => _selectedPlan = 'monthly'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _PlanCard(
                          label: 'Annual',
                          price: '\$119.99',
                          period: '/year',
                          badge: 'SAVE 33%',
                          selected: _selectedPlan == 'annual',
                          textColor: textColor,
                          subColor: subColor,
                          onTap: () =>
                              setState(() => _selectedPlan = 'annual'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ...SubscriptionPaywallScreen._proFeatures.map(
                    (feature) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: GlassCard(
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          children: [
                            Text(
                              feature.$1,
                              style: const TextStyle(fontSize: 24),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Text(
                                feature.$2,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: textColor,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.check_circle_rounded,
                              color: AppColors.purple,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  PrimaryButton(
                    label: 'Subscribe Now',
                    variant: PrimaryButtonVariant.purple,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Welcome to OctaFit Pro!',
                            style: GoogleFonts.inter(),
                          ),
                          backgroundColor: AppColors.purple,
                        ),
                      );
                      context.push(AppRoutes.membership);
                    },
                  ),
                  const SizedBox(height: 12),
                  GhostButton(
                    label: 'Restore Purchases',
                    onPressed: () {},
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Cancel anytime. Terms & Privacy apply.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(fontSize: 11, color: subColor),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.label,
    required this.price,
    required this.period,
    required this.selected,
    required this.textColor,
    required this.subColor,
    required this.onTap,
    this.badge,
  });

  final String label;
  final String price;
  final String period;
  final String? badge;
  final bool selected;
  final Color textColor;
  final Color subColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      glow: selected ? GlassGlow.purple : GlassGlow.none,
      padding: const EdgeInsets.all(16),
      onTap: onTap,
      child: Column(
        children: [
          if (badge != null) ...[
            BadgeWidget(label: badge!, color: BadgeColor.green),
            const SizedBox(height: 8),
          ],
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: subColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            price,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: selected ? AppColors.purple : textColor,
            ),
          ),
          Text(
            period,
            style: GoogleFonts.inter(fontSize: 11, color: subColor),
          ),
        ],
      ),
    );
  }
}

