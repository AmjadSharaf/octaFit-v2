import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/widgets/badge_widget.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/top_bar.dart';

class TransformationTimelineScreen extends StatelessWidget {
  const TransformationTimelineScreen({super.key});

  static const _milestones = [
    (date: 'Mar 2026', title: 'Journey Started', detail: 'Baseline assessment completed', status: 'Done', color: BadgeColor.green),
    (date: 'Apr 2026', title: 'First PR', detail: 'Squat 100kg × 5 reps', status: 'Done', color: BadgeColor.green),
    (date: 'May 2026', title: 'Body Comp Scan', detail: 'Body fat down 2.1%', status: 'Done', color: BadgeColor.green),
    (date: 'Jun 2026', title: '74% Progress', detail: 'Digital twin model updated', status: 'Current', color: BadgeColor.blue),
    (date: 'Jul 2026', title: 'Strength Milestone', detail: 'Projected: Deadlift 160kg', status: 'Upcoming', color: BadgeColor.purple),
    (date: 'Aug 2026', title: 'Goal Physique', detail: 'Target body fat 12%', status: 'Upcoming', color: BadgeColor.orange),
    (date: 'Sep 2026', title: '90-Day Review', detail: 'Full transformation assessment', status: 'Upcoming', color: BadgeColor.purple),
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
          const OctaTopBar(title: 'Transformation Timeline', showBack: true),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: Column(
                children: List.generate(_milestones.length, (index) {
                  final item = _milestones[index];
                  final isLast = index == _milestones.length - 1;
                  final isCurrent = item.status == 'Current';

                  return IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 32,
                          child: Column(
                            children: [
                              Container(
                                width: 14,
                                height: 14,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: isCurrent ? AppColors.gradBoth : null,
                                  color: isCurrent
                                      ? null
                                      : (item.status == 'Done'
                                          ? AppColors.green
                                          : AppColors.purple.withValues(alpha: 0.4)),
                                  border: isCurrent
                                      ? null
                                      : Border.all(
                                          color: item.status == 'Upcoming'
                                              ? AppColors.glassBorder
                                              : Colors.transparent,
                                        ),
                                ),
                              ),
                              if (!isLast)
                                Expanded(
                                  child: Container(
                                    width: 2,
                                    margin: const EdgeInsets.symmetric(vertical: 4),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          isCurrent ? AppColors.blue : AppColors.glassBorder,
                                          AppColors.glassBorder,
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
                            child: GlassCard(
                              glow: isCurrent ? GlassGlow.blue : GlassGlow.none,
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        item.date,
                                        style: GoogleFonts.inter(
                                          fontSize: 12,
                                          color: subColor,
                                        ),
                                      ),
                                      const Spacer(),
                                      BadgeWidget(label: item.status, color: item.color),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    item.title,
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: textColor,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    item.detail,
                                    style: GoogleFonts.inter(
                                      fontSize: 13,
                                      color: subColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
