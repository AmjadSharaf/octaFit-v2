import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/routing/app_routes.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/progress_ring.dart';
import 'package:octafit/core/widgets/section_header.dart';
import 'package:octafit/core/widgets/stat_card.dart';
import 'package:octafit/core/widgets/top_bar.dart';

class DigitalAthleteHubScreen extends StatelessWidget {
  const DigitalAthleteHubScreen({super.key});

  static const _progress = 74;

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
          const OctaTopBar(title: 'Digital Athlete', showBack: true),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlassCard(
                    glow: GlassGlow.purple,
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () => context.push(AppRoutes.avatarViewer),
                          child: Container(
                            width: 140,
                            height: 200,
                            decoration: BoxDecoration(
                              gradient: AppColors.gradBoth,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: AppColors.purpleGlow(blur: 24),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Icon(
                                  Icons.accessibility_new_rounded,
                                  size: 100,
                                  color: AppColors.white.withValues(alpha: 0.35),
                                ),
                                Positioned(
                                  bottom: 12,
                                  child: Text(
                                    'Tap to view 3D',
                                    style: GoogleFonts.inter(
                                      fontSize: 11,
                                      color: AppColors.white.withValues(alpha: 0.8),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ProgressRing(
                          value: _progress.toDouble(),
                          size: 90,
                          strokeWidth: 6,
                          color: AppColors.cyan,
                          center: Text(
                            '$_progress%',
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: textColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Transformation Progress',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: textColor,
                          ),
                        ),
                        Text(
                          'Body composition & performance model',
                          style: GoogleFonts.inter(fontSize: 12, color: subColor),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: StatCard(
                          icon: const Icon(Icons.trending_up_rounded),
                          label: 'Strength Index',
                          value: '+18',
                          unit: '%',
                          color: AppColors.green,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: StatCard(
                          icon: const Icon(Icons.speed_rounded),
                          label: 'Body Fat',
                          value: '-4.2',
                          unit: '%',
                          color: AppColors.blue,
                        ),
                      ),
                    ],
                  ),
                  const SectionHeader(title: 'Explore'),
                  _LinkCard(
                    icon: Icons.insights_rounded,
                    title: '30/60/90 Day Predictions',
                    subtitle: 'AI forecasts your transformation trajectory',
                    color: AppColors.blue,
                    textColor: textColor,
                    subColor: subColor,
                    onTap: () => context.push(AppRoutes.predictions),
                  ),
                  const SizedBox(height: 10),
                  _LinkCard(
                    icon: Icons.timeline_rounded,
                    title: 'Transformation Timeline',
                    subtitle: 'Milestones from start to goal physique',
                    color: AppColors.purple,
                    textColor: textColor,
                    subColor: subColor,
                    onTap: () => context.push(AppRoutes.transformationTimeline),
                  ),
                  const SizedBox(height: 10),
                  _LinkCard(
                    icon: Icons.view_in_ar_rounded,
                    title: '3D Avatar Viewer',
                    subtitle: 'Interactive digital twin visualization',
                    color: AppColors.cyan,
                    textColor: textColor,
                    subColor: subColor,
                    onTap: () => context.push(AppRoutes.avatarViewer),
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

class _LinkCard extends StatelessWidget {
  const _LinkCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.textColor,
    required this.subColor,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final Color textColor;
  final Color subColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      onTap: onTap,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(fontSize: 12, color: subColor),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: subColor),
        ],
      ),
    );
  }
}

