import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/widgets/badge_widget.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/section_header.dart';
import 'package:octafit/core/widgets/top_bar.dart';

class MobilityHubScreen extends StatelessWidget {
  const MobilityHubScreen({super.key});

  static const _routines = [
    (icon: '🦵', title: 'Hip Opener Flow', duration: '12 min', level: 'Beginner', color: BadgeColor.green),
    (icon: '🔙', title: 'Thoracic Spine Reset', duration: '10 min', level: 'All Levels', color: BadgeColor.blue),
    (icon: '💪', title: 'Shoulder CARs', duration: '8 min', level: 'Intermediate', color: BadgeColor.purple),
    (icon: '🦶', title: 'Ankle Mobility', duration: '15 min', level: 'Beginner', color: BadgeColor.green),
    (icon: '🧘', title: 'Full Body Flow', duration: '20 min', level: 'All Levels', color: BadgeColor.blue),
    (icon: '⚡', title: 'Pre-Workout Activation', duration: '6 min', level: 'All Levels', color: BadgeColor.orange),
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
          const OctaTopBar(title: 'Mobility Hub', showBack: true),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlassCard(
                    glow: GlassGlow.blue,
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        const Text('🧘', style: TextStyle(fontSize: 36)),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Move Better',
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: textColor,
                                ),
                              ),
                              Text(
                                'AI-curated mobility routines for recovery and performance.',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: subColor,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SectionHeader(title: 'Routines'),
                  ..._routines.map(
                    (routine) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: GlassCard(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Text(routine.icon, style: const TextStyle(fontSize: 28)),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    routine.title,
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: textColor,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      BadgeWidget(label: routine.duration, color: routine.color),
                                      const SizedBox(width: 8),
                                      BadgeWidget(label: routine.level, color: BadgeColor.purple),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.play_circle_fill_rounded, color: AppColors.blue, size: 32),
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
