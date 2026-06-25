import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/widgets/badge_widget.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/progress_ring.dart';
import 'package:octafit/core/widgets/section_header.dart';
import 'package:octafit/core/widgets/top_bar.dart';

class PredictionsScreen extends StatelessWidget {
  const PredictionsScreen({super.key});

  static const _predictions = [
    (
      days: 30,
      label: '30 Days',
      strength: '+6%',
      bodyFat: '-1.2%',
      weight: '-2.1 kg',
      confidence: 88,
      summary: 'Early adaptation phase — visible posture improvements and initial strength gains.',
    ),
    (
      days: 60,
      label: '60 Days',
      strength: '+14%',
      bodyFat: '-2.8%',
      weight: '-3.5 kg',
      confidence: 82,
      summary: 'Hypertrophy window opens — muscle definition becomes noticeable.',
    ),
    (
      days: 90,
      label: '90 Days',
      strength: '+22%',
      bodyFat: '-4.5%',
      weight: '-5.2 kg',
      confidence: 76,
      summary: 'Peak transformation — goal physique within reach with consistent adherence.',
    ),
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
          const OctaTopBar(title: 'Predictions', showBack: true),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlassCard(
                    glow: GlassGlow.blue,
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Icon(Icons.auto_graph_rounded, color: AppColors.cyan, size: 28),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'AI-powered forecasts based on your training, nutrition, and recovery data.',
                            style: GoogleFonts.inter(fontSize: 13, color: subColor, height: 1.4),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SectionHeader(title: '30 / 60 / 90 Day Outlook'),
                  ..._predictions.map(
                    (pred) => Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: GlassCard(
                        glow: pred.days == 90 ? GlassGlow.purple : GlassGlow.none,
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  pred.label,
                                  style: GoogleFonts.spaceGrotesk(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: textColor,
                                  ),
                                ),
                                const Spacer(),
                                ProgressRing(
                                  value: pred.confidence.toDouble(),
                                  size: 48,
                                  strokeWidth: 4,
                                  color: AppColors.green,
                                  center: Text(
                                    '${pred.confidence}',
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: textColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            const BadgeWidget(label: 'Confidence %', color: BadgeColor.green),
                            const SizedBox(height: 14),
                            Row(
                              children: [
                                _MetricChip(label: 'Strength', value: pred.strength, color: AppColors.blue),
                                const SizedBox(width: 8),
                                _MetricChip(label: 'Body Fat', value: pred.bodyFat, color: AppColors.orange),
                                const SizedBox(width: 8),
                                _MetricChip(label: 'Weight', value: pred.weight, color: AppColors.purple),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              pred.summary,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: subColor,
                                height: 1.5,
                              ),
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

class _MetricChip extends StatelessWidget {
  const _MetricChip({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.white : AppColors.lightText;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
            Text(
              label,
              style: GoogleFonts.inter(fontSize: 10, color: textColor.withValues(alpha: 0.6)),
            ),
          ],
        ),
      ),
    );
  }
}
