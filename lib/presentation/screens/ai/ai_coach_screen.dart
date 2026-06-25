import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/widgets/bottom_nav_bar.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/primary_button.dart';
import 'package:octafit/core/widgets/section_header.dart';
import 'package:octafit/core/widgets/top_bar.dart';

class AiCoachScreen extends StatelessWidget {
  const AiCoachScreen({super.key});

  static const _quickActions = [
    ('💪', 'Plan my workout', 'Get a session tailored to your goals'),
    ('🥗', 'Nutrition advice', 'Macros, meals & supplement tips'),
    ('😴', 'Recovery check', 'Sleep, soreness & readiness score'),
    ('📊', 'Progress review', 'Analyze your training trends'),
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
          const OctaTopBar(title: 'AI Coach', showBack: true),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: Column(
                children: [
                  GlassCard(
                    glow: GlassGlow.blue,
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: AppColors.gradBoth,
                            boxShadow: AppColors.blueGlow(blur: 30),
                          ),
                          child: const Center(
                            child: Text('OCTA', style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: AppColors.white,
                            )),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Coach OCTA',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Your AI-powered personal trainer. Real-time guidance based on your biomechanics, goals, and recovery data.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: subColor,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 20),
                        PrimaryButton(
                          label: 'Start Conversation',
                          variant: PrimaryButtonVariant.gradient,
                          icon: const Icon(Icons.chat_rounded, color: AppColors.white, size: 20),
                          onPressed: () => context.push(AppRoutes.aiChat),
                        ),
                      ],
                    ),
                  ),
                  const SectionHeader(title: 'Quick Actions'),
                  ..._quickActions.map(
                    (action) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: GlassCard(
                        onTap: () => context.push(AppRoutes.aiChat),
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Text(action.$1, style: const TextStyle(fontSize: 28)),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    action.$2,
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: textColor,
                                    ),
                                  ),
                                  Text(
                                    action.$3,
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: subColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.chevron_right_rounded, color: subColor),
                          ],
                        ),
                      ),
                    ),
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
