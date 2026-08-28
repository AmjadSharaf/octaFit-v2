import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/widgets/avatar_widget.dart';
import 'package:octafit/core/widgets/badge_widget.dart';
import 'package:octafit/core/widgets/bottom_nav_bar.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/progress_ring.dart';
import 'package:octafit/core/widgets/section_header.dart';
import 'package:octafit/core/widgets/stat_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            Row(
              children: [
                const AvatarWidget(size: 72, initials: 'AS', glow: true),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Amjad Sharaf',
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: textColor,
                            ),
                          ),
                          // const SizedBox(width: 8),
                          // const BadgeWidget(
                          //   label: 'PRO',
                          //   color: BadgeColor.purple,
                          // ),
                        ],
                      ),
                      Text(
                        '@amjad_octa',
                        style: GoogleFonts.inter(fontSize: 13, color: subColor),
                      ),
                      Text(
                        'Build Muscle · Advanced',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppColors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => context.push(AppRoutes.settings),
                  icon: Icon(Icons.settings_rounded, color: textColor),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Row(
            //   children: [
            //     Expanded(
            //       child: StatCard(
            //         icon: const Icon(Icons.fitness_center_rounded),
            //         label: 'Workouts',
            //         value: '142',
            //         color: AppColors.blue,
            //       ),
            //     ),
            //     const SizedBox(width: 10),
            //     Expanded(
            //       child: StatCard(
            //         icon: const Icon(Icons.local_fire_department_rounded),
            //         label: 'Streak',
            //         value: '14',
            //         unit: ' days',
            //         color: AppColors.orange,
            //       ),
            //     ),
            //     const SizedBox(width: 10),
            //     Expanded(
            //       child: StatCard(
            //         icon: const Icon(Icons.emoji_events_rounded),
            //         label: 'PRs',
            //         value: '23',
            //         color: AppColors.purple,
            //       ),
            //     ),
            //   ],
            // ),
            // const SectionHeader(title: 'Weekly Goals'),
            // GlassCard(
            //   glow: GlassGlow.blue,
            //   padding: const EdgeInsets.all(20),
            //   child: Row(
            //     children: [
            //       ProgressRing(
            //         value: 80,
            //         size: 72,
            //         center: Text(
            //           '80%',
            //           style: GoogleFonts.spaceGrotesk(
            //             fontSize: 14,
            //             fontWeight: FontWeight.w700,
            //             color: textColor,
            //           ),
            //         ),
            //       ),
            //       const SizedBox(width: 20),
            //       Expanded(
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             _GoalRow(
            //               label: 'Workouts',
            //               current: '4',
            //               target: '5',
            //               textColor: textColor,
            //               subColor: subColor,
            //             ),
            //             const SizedBox(height: 8),
            //             _GoalRow(
            //               label: 'Calories',
            //               current: '9.9k',
            //               target: '12k',
            //               textColor: textColor,
            //               subColor: subColor,
            //             ),
            //             const SizedBox(height: 8),
            // _GoalRow(
            //   label: 'Hours',
            //   current: '6.8',
            //   target: '8',
            //   textColor: textColor,
            //   subColor: subColor,
            // ),
            // ],
            // ),
            // ),
            // ],
            // ),
            // ),
            const SectionHeader(title: 'Activity'),
            ..._activityItems(context).map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: GlassCard(
                  onTap: item.$3,
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      Text(item.$1, style: const TextStyle(fontSize: 24)),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          item.$2,
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: textColor,
                          ),
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
    );
  }

  static List<(String, String, VoidCallback)> _activityItems(
    BuildContext context,
  ) => [
    // ('🏆', 'Achievements', () => context.push(AppRoutes.achievements)),
    // ('🎯', 'Challenges', () => context.push(AppRoutes.challenges)),
    // ('📊', 'Milestones', () => context.push(AppRoutes.milestones)),
    ('👥', 'Community', () => context.push(AppRoutes.community)),
    ('🏟️', 'Sports Groups', () => context.push(AppRoutes.sportsGroups)),
    ('✏️', 'Edit Profile', () => context.push(AppRoutes.editProfile)),
    ('⚙️', 'Settings', () => context.push(AppRoutes.settings)),
    ('⭐', 'Membership', () => context.push(AppRoutes.membership)),
    // ('💎', 'Upgrade to Pro', () => context.push(AppRoutes.subscriptionPaywall)),
  ];
}

// class _GoalRow extends StatelessWidget {
//   const _GoalRow({
//     required this.label,
//     required this.current,
//     required this.target,
//     required this.textColor,
//     required this.subColor,
//   });

//   final String label;
//   final String current;
//   final String target;
//   final Color textColor;
//   final Color subColor;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         SizedBox(
//           width: 72,
//           child: Text(
//             label,
//             style: GoogleFonts.inter(fontSize: 12, color: subColor),
//           ),
//         ),
//         Text(
//           '$current / $target',
//           style: GoogleFonts.spaceGrotesk(
//             fontSize: 13,
//             fontWeight: FontWeight.w600,
//             color: textColor,
//           ),
//         ),
//       ],
//     );
//   }
// }
