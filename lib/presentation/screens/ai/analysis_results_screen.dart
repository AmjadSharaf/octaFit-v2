import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/routing/app_routes.dart';
import 'package:octafit/core/widgets/badge_widget.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/primary_button.dart';
import 'package:octafit/core/widgets/progress_ring.dart';
import 'package:octafit/core/widgets/section_header.dart';
import 'package:octafit/core/widgets/top_bar.dart';
import 'package:octafit/features/ai_motion_analyzer/domain/entities/motion_analysis.dart';
import 'package:octafit/features/ai_motion_analyzer/presentation/cubit/motion_analyzer_cubit.dart';

class AnalysisResultsScreen extends StatelessWidget {
  const AnalysisResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MotionAnalyzerCubit, MotionAnalyzerState>(
      builder: (context, state) {
        final analysis = state.analysisResult;
        if (analysis == null) {
          return const _EmptyResults();
        }

        final isDark = Theme.of(context).brightness == Brightness.dark;
        final textColor = isDark ? AppColors.white : AppColors.lightText;
        final subColor = isDark ? AppColors.gray : AppColors.lightGray;

        return OctaScreen(
          showOrbs: true,
          safeArea: false,
          body: Column(
            children: [
              const OctaTopBar(title: 'Analysis Results', showBack: true),
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
                            ProgressRing(
                              value: analysis.overallScore.toDouble(),
                              size: 120,
                              strokeWidth: 6,
                              color: _scoreColor(analysis.overallScore),
                              center: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '${analysis.overallScore}',
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 32,
                                      fontWeight: FontWeight.w700,
                                      color: textColor,
                                    ),
                                  ),
                                  Text(
                                    'Score',
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: subColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              analysis.exercise,
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: textColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _scoreLabel(analysis.overallScore),
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: _scoreColor(analysis.overallScore),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SectionHeader(title: 'Form Breakdown'),
                      ...analysis.jointAngles.map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: _JointAngleCard(item: item, textColor: textColor, subColor: subColor),
                        ),
                      ),
                      const SectionHeader(title: 'Coaching Tips'),
                      ...analysis.tips.map(
                        (tip) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: GlassCard(
                            padding: const EdgeInsets.all(14),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.lightbulb_outline_rounded,
                                  color: AppColors.orange,
                                  size: 20,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    tip,
                                    style: GoogleFonts.inter(
                                      fontSize: 13,
                                      color: textColor,
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      PrimaryButton(
                        label: 'Back to AI Hub',
                        variant: PrimaryButtonVariant.blue,
                        onPressed: () => context.go(AppRoutes.aiHub),
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

  static Color _scoreColor(int score) {
    if (score >= 90) return AppColors.green;
    if (score >= 75) return AppColors.blue;
    return AppColors.orange;
  }

  static String _scoreLabel(int score) {
    if (score >= 90) return 'Excellent form!';
    if (score >= 75) return 'Good — minor tweaks needed';
    return 'Needs improvement';
  }
}

class _EmptyResults extends StatelessWidget {
  const _EmptyResults();

  @override
  Widget build(BuildContext context) {
    return OctaScreen(
      showOrbs: true,
      safeArea: false,
      body: Column(
        children: [
          const OctaTopBar(title: 'Analysis Results', showBack: true),
          const Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: AppColors.blue),
                  SizedBox(height: 16),
                  Text(
                    'Waiting for analysis results...',
                    style: TextStyle(color: AppColors.gray, fontSize: 14),
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

class _JointAngleCard extends StatelessWidget {
  const _JointAngleCard({
    required this.item,
    required this.textColor,
    required this.subColor,
  });

  final JointAngle item;
  final Color textColor;
  final Color subColor;

  BadgeColor get _badgeColor => switch (item.status) {
        'Excellent' => BadgeColor.green,
        'Good' => BadgeColor.blue,
        'Needs Work' => BadgeColor.orange,
        _ => BadgeColor.purple,
      };

  int get _score => (100 - item.deviation).round().clamp(0, 100);

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.joint,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 4),
                BadgeWidget(label: item.status, color: _badgeColor),
              ],
            ),
          ),
          Text(
            '$_score',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
