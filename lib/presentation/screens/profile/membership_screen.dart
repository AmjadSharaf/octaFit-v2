import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/widgets/badge_widget.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/primary_button.dart';
import 'package:octafit/core/widgets/top_bar.dart';

class MembershipScreen extends StatelessWidget {
  const MembershipScreen({super.key});

  static const _proFeatures = [
    ('🤖', 'Unlimited AI Coach sessions'),
    ('📹', 'Advanced motion analysis'),
    ('📊', 'Detailed analytics & insights'),
    ('🏋️', 'All premium programs'),
    ('🎯', 'Personalized meal plans'),
    ('👥', 'Priority community support'),
  ];

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
          const OctaTopBar(title: 'Membership', showBack: true),
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
                        const BadgeWidget(label: 'OCTAFIT PRO', color: BadgeColor.purple),
                        const SizedBox(height: 16),
                        Text(
                          'You\'re a Pro Member',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Renews on Dec 15, 2026',
                          style: GoogleFonts.inter(fontSize: 13, color: subColor),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '\$14.99/month',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: AppColors.purple,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ..._proFeatures.map(
                    (feature) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: GlassCard(
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          children: [
                            Text(feature.$1, style: const TextStyle(fontSize: 24)),
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
                              color: AppColors.green,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  PrimaryButton(
                    label: 'Manage Subscription',
                    variant: PrimaryButtonVariant.purple,
                    onPressed: () {},
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
