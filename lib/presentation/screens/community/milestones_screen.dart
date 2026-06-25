import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/progress_ring.dart';
import 'package:octafit/core/widgets/section_header.dart';
import 'package:octafit/core/widgets/top_bar.dart';

class _Milestone {
  const _Milestone({
    required this.title,
    required this.description,
    required this.icon,
    required this.progress,
    required this.target,
    required this.unit,
    required this.completed,
  });

  final String title;
  final String description;
  final String icon;
  final int progress;
  final int target;
  final String unit;
  final bool completed;
}

const _milestones = <_Milestone>[
  _Milestone(
    title: 'First 100 Workouts',
    description: 'Complete 100 training sessions',
    icon: '💯',
    progress: 100,
    target: 100,
    unit: 'workouts',
    completed: true,
  ),
  _Milestone(
    title: 'Iron Streak',
    description: '30 consecutive training days',
    icon: '🔥',
    progress: 14,
    target: 30,
    unit: 'days',
    completed: false,
  ),
  _Milestone(
    title: 'Distance Runner',
    description: 'Run 500 km total',
    icon: '🏃',
    progress: 312,
    target: 500,
    unit: 'km',
    completed: false,
  ),
  _Milestone(
    title: 'Strength Legend',
    description: 'Lift 50,000 kg total volume',
    icon: '🏋️',
    progress: 38500,
    target: 50000,
    unit: 'kg',
    completed: false,
  ),
  _Milestone(
    title: 'Community Builder',
    description: 'Earn 5,000 likes on posts',
    icon: '❤️',
    progress: 3200,
    target: 5000,
    unit: 'likes',
    completed: false,
  ),
  _Milestone(
    title: 'Challenge Champion',
    description: 'Complete 10 community challenges',
    icon: '🏆',
    progress: 6,
    target: 10,
    unit: 'challenges',
    completed: false,
  ),
];

class MilestonesScreen extends StatelessWidget {
  const MilestonesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final milestones = _milestones;
    final completed = milestones.where((m) => m.completed).length;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.white : AppColors.lightText;
    final subColor = isDark ? AppColors.gray : AppColors.lightGray;

    return OctaScreen(
      showOrbs: true,
      safeArea: false,
      body: Column(
        children: [
          const OctaTopBar(title: 'Milestones', showBack: true),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlassCard(
                    glow: GlassGlow.purple,
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        ProgressRing(
                          value: (completed / milestones.length) * 100,
                          size: 64,
                          center: Text(
                            '$completed',
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
                                '$completed of ${milestones.length} Reached',
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: textColor,
                                ),
                              ),
                              Text(
                                'Track your long-term fitness journey',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: subColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SectionHeader(title: 'Your Milestones'),
                  ...milestones.map(
                    (milestone) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _MilestoneCard(
                        milestone: milestone,
                        textColor: textColor,
                        subColor: subColor,
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

class _MilestoneCard extends StatelessWidget {
  const _MilestoneCard({
    required this.milestone,
    required this.textColor,
    required this.subColor,
  });

  final _Milestone milestone;
  final Color textColor;
  final Color subColor;

  @override
  Widget build(BuildContext context) {
    final percent = (milestone.progress / milestone.target * 100)
        .clamp(0, 100)
        .toInt();

    return GlassCard(
      glow: milestone.completed ? GlassGlow.blue : GlassGlow.none,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Text(
            milestone.icon,
            style: TextStyle(
              fontSize: 36,
              color: milestone.completed ? null : AppColors.dimGray,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  milestone.title,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: milestone.completed ? textColor : subColor,
                  ),
                ),
                Text(
                  milestone.description,
                  style: GoogleFonts.inter(fontSize: 11, color: subColor),
                ),
                const SizedBox(height: 10),
                if (milestone.completed)
                  Row(
                    children: [
                      const Icon(
                        Icons.check_circle_rounded,
                        color: AppColors.green,
                        size: 18,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Completed!',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.green,
                        ),
                      ),
                    ],
                  )
                else ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: milestone.progress / milestone.target,
                      backgroundColor: AppColors.chipInactive,
                      color: AppColors.blue,
                      minHeight: 6,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${_formatProgress(milestone.progress)} / ${_formatProgress(milestone.target)} ${milestone.unit} · $percent%',
                    style: GoogleFonts.inter(fontSize: 11, color: subColor),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  static String _formatProgress(int value) {
    if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}k';
    }
    return '$value';
  }
}
