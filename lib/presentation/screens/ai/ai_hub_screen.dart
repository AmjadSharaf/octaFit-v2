import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/widgets/bottom_nav_bar.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/section_header.dart';

const _aiStatus = (status: 'Active', score: 94, label: 'AI Engine Online');

const _aiInsights = [
  'Squat depth improved 12% this week',
  'Recovery score: 87% — ready for moderate training',
  'Protein intake 8% below target for hypertrophy phase',
  'Left hip mobility 8% below right — add mobility work',
];

class AiHubScreen extends StatelessWidget {
  const AiHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final status = _aiStatus;
    final insights = _aiInsights;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.white : AppColors.lightText;
    final subColor = isDark ? AppColors.gray : AppColors.lightGray;

    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'AI Hub',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
            Text(
              'Your intelligent training companion',
              style: GoogleFonts.inter(fontSize: 14, color: subColor),
            ),
            const SizedBox(height: 20),
            // GlassCard(
            //   glow: GlassGlow.purple,
            //   padding: const EdgeInsets.all(20),
            //   child: Row(
            //     children: [
            //       Container(
            //         width: 56,
            //         height: 56,
            //         decoration: BoxDecoration(
            //           gradient: AppColors.gradBoth,
            //           borderRadius: BorderRadius.circular(16),
            //         ),
            //         child: const Center(
            //           child: Text('🤖', style: TextStyle(fontSize: 28)),
            //         ),
            //       ),
            //       const SizedBox(width: 16),
            //       Expanded(
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text(
            //               status.label,
            //               style: GoogleFonts.spaceGrotesk(
            //                 fontSize: 16,
            //                 fontWeight: FontWeight.w700,
            //                 color: textColor,
            //               ),
            //             ),
            //             const SizedBox(height: 4),
            //             Row(
            //               children: [
            //                 Container(
            //                   width: 8,
            //                   height: 8,
            //                   decoration: const BoxDecoration(
            //                     color: AppColors.green,
            //                     shape: BoxShape.circle,
            //                   ),
            //                 ),
            //                 const SizedBox(width: 6),
            //                 Text(
            //                   '${status.status} · ${status.score}% accuracy',
            //                   style: GoogleFonts.inter(
            //                     fontSize: 12,
            //                     color: subColor,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            const SectionHeader(title: 'AI Features'),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.1,
              children: [
                // _FeatureTile(
                //   icon: '🧠',
                //   title: 'AI Coach',
                //   subtitle: 'Personal guidance',
                //   color: AppColors.blue,
                //   onTap: () => context.push(AppRoutes.aiCoach),
                // ),
                _FeatureTile(
                  icon: '💬',
                  title: 'AI Chat',
                  subtitle: 'Ask anything',
                  color: AppColors.purple,
                  onTap: () => context.push(AppRoutes.aiChat),
                ),
                // _FeatureTile(
                //   icon: '📹',
                //   title: 'Motion Analyzer',
                //   subtitle: 'Form analysis',
                //   color: AppColors.cyan,
                //   onTap: () => context.push(AppRoutes.motionAnalyzer),
                // ),
                _FeatureTile(
                  icon: '🩺',
                  title: 'AI Physio',
                  subtitle: 'Recovery & pain',
                  color: AppColors.green,
                  onTap: () => context.push(AppRoutes.physio),
                ),
                // _FeatureTile(
                //   icon: '📋',
                //   title: 'Smart Plan',
                //   subtitle: 'AI programs',
                //   color: AppColors.purple,
                //   onTap: () => context.push(AppRoutes.personalizedPlan),
                // ),
                _FeatureTile(
                  icon: '🥗',
                  title: 'Nutrition AI',
                  subtitle: 'Meal tracking',
                  color: AppColors.green,
                  onTap: () => context.push(AppRoutes.nutrition),
                ),
                _FeatureTile(
                  icon: '⚡',
                  title: 'Digital Athlete',
                  subtitle: '3D predictions',
                  color: AppColors.blue,
                  onTap: () => context.push(AppRoutes.digitalAthlete),
                ),
                // _FeatureTile(
                //   icon: '🏆',
                //   title: 'Habit Tracker',
                //   subtitle: 'Build habits',
                //   color: AppColors.orange,
                //   onTap: () => context.push(AppRoutes.habitTracker),
                // ),
              ],
            ),
            const SectionHeader(title: 'Today\'s Insights'),
            ...insights.map(
              (insight) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: GlassCard(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.auto_awesome_rounded,
                        color: AppColors.blue,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          insight,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: textColor,
                          ),
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
    );
  }
}

class _FeatureTile extends StatelessWidget {
  const _FeatureTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  final String icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.white : AppColors.lightText;
    final subColor = isDark ? AppColors.gray : AppColors.lightGray;

    return GlassCard(
      onTap: onTap,
      glow: GlassGlow.none,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(icon, style: const TextStyle(fontSize: 22)),
            ),
          ),
          const Spacer(),
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
            style: GoogleFonts.inter(fontSize: 11, color: subColor),
          ),
        ],
      ),
    );
  }
}
