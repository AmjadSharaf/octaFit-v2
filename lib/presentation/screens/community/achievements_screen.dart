import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/progress_ring.dart';
import 'package:octafit/core/widgets/top_bar.dart';
import 'package:octafit/features/community/presentation/cubit/community_cubit.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

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
          const OctaTopBar(title: 'Achievements', showBack: true),
          Expanded(
            child: BlocBuilder<CommunityCubit, CommunityState>(
              builder: (context, state) {
                final achievements = state.achievements;
                final unlocked = achievements.where((a) => a.unlocked).length;
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                  child: Column(
                    children: [
                      GlassCard(
                        glow: GlassGlow.purple,
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            ProgressRing(
                              value: (unlocked / achievements.length) * 100,
                              size: 64,
                              center: Text(
                                '$unlocked',
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
                                    '$unlocked of ${achievements.length} Unlocked',
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: textColor,
                                    ),
                                  ),
                                  Text(
                                    'Keep training to earn more badges',
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
                      const SizedBox(height: 16),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.85,
                        ),
                        itemCount: achievements.length,
                        itemBuilder: (context, index) {
                          return _BadgeCard(
                            achievement: achievements[index],
                            textColor: textColor,
                            subColor: subColor,
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _BadgeCard extends StatelessWidget {
  const _BadgeCard({
    required this.achievement,
    required this.textColor,
    required this.subColor,
  });

  final AchievementEntry achievement;
  final Color textColor;
  final Color subColor;

  @override
  Widget build(BuildContext context) {
    final unlocked = achievement.unlocked;

    return GlassCard(
      glow: unlocked ? GlassGlow.blue : GlassGlow.none,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            achievement.icon,
            style: TextStyle(
              fontSize: 36,
              color: unlocked ? null : AppColors.dimGray,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            achievement.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: unlocked ? textColor : subColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            achievement.description,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(fontSize: 10, color: subColor),
          ),
          const SizedBox(height: 10),
          if (unlocked)
            const Icon(Icons.check_circle_rounded, color: AppColors.green, size: 20)
          else
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: achievement.progress / 100,
                    backgroundColor: AppColors.chipInactive,
                    color: AppColors.blue,
                    minHeight: 4,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${achievement.progress}%',
                  style: GoogleFonts.inter(fontSize: 10, color: subColor),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
