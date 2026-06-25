import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/routing/app_routes.dart';
import 'package:octafit/core/widgets/badge_widget.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/progress_ring.dart';
import 'package:octafit/core/widgets/section_header.dart';
import 'package:octafit/core/widgets/top_bar.dart';

class MovementHistoryScreen extends StatelessWidget {
  const MovementHistoryScreen({super.key});

  static const _analyses = [
    (exercise: 'Barbell Squat', date: 'Jun 10, 2026', score: 87),
    (exercise: 'Deadlift', date: 'Jun 8, 2026', score: 92),
    (exercise: 'Bench Press', date: 'Jun 5, 2026', score: 78),
    (exercise: 'Overhead Press', date: 'Jun 2, 2026', score: 85),
    (exercise: 'Pull-up', date: 'May 28, 2026', score: 91),
    (exercise: 'Barbell Squat', date: 'May 25, 2026', score: 82),
  ];

  static Color _scoreColor(int score) {
    if (score >= 90) return AppColors.green;
    if (score >= 75) return AppColors.blue;
    return AppColors.orange;
  }

  static BadgeColor _badgeColor(int score) {
    if (score >= 90) return BadgeColor.green;
    if (score >= 75) return BadgeColor.blue;
    return BadgeColor.orange;
  }

  static String _scoreLabel(int score) {
    if (score >= 90) return 'Excellent';
    if (score >= 75) return 'Good';
    return 'Needs Work';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.white : AppColors.lightText;
    final subColor = isDark ? AppColors.gray : AppColors.lightGray;
    final avgScore = (_analyses.map((a) => a.score).reduce((a, b) => a + b) / _analyses.length).round();

    return OctaScreen(
      showOrbs: true,
      safeArea: false,
      body: Column(
        children: [
          const OctaTopBar(title: 'Movement History', showBack: true),
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
                        ProgressRing(
                          value: avgScore.toDouble(),
                          size: 72,
                          strokeWidth: 5,
                          color: _scoreColor(avgScore),
                          center: Text(
                            '$avgScore',
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: textColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Average Form Score',
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: textColor,
                                ),
                              ),
                              Text(
                                '${_analyses.length} analyses recorded',
                                style: GoogleFonts.inter(fontSize: 12, color: subColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SectionHeader(title: 'Past Analyses'),
                  ..._analyses.map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: GlassCard(
                        onTap: () => context.push(AppRoutes.analysisResults),
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: _scoreColor(item.score).withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  '${item.score}',
                                  style: GoogleFonts.spaceGrotesk(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: _scoreColor(item.score),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.exercise,
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: textColor,
                                    ),
                                  ),
                                  Text(
                                    item.date,
                                    style: GoogleFonts.inter(fontSize: 12, color: subColor),
                                  ),
                                ],
                              ),
                            ),
                            BadgeWidget(
                              label: _scoreLabel(item.score),
                              color: _badgeColor(item.score),
                            ),
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

