import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/widgets/avatar_widget.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/top_bar.dart';
import 'package:octafit/features/community/presentation/cubit/community_cubit.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

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
          const OctaTopBar(title: 'Leaderboard', showBack: true),
          Expanded(
            child: BlocBuilder<CommunityCubit, CommunityState>(
              builder: (context, state) {
                final entries = state.leaderboard;
                return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                  itemCount: entries.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final entry = entries[index];
                    return GlassCard(
                      glow: entry.isMe ? GlassGlow.blue : GlassGlow.none,
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 32,
                            child: entry.badge.isNotEmpty
                                ? Text(entry.badge, style: const TextStyle(fontSize: 22))
                                : Text(
                                    '#${entry.rank}',
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: subColor,
                                    ),
                                  ),
                          ),
                          const SizedBox(width: 12),
                          AvatarWidget(
                            size: 40,
                            initials: entry.initials,
                            glow: entry.isMe,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  entry.isMe ? '${entry.name} (You)' : entry.name,
                                  style: GoogleFonts.spaceGrotesk(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: entry.isMe ? AppColors.blue : textColor,
                                  ),
                                ),
                                Text(
                                  '${entry.points} pts',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: subColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (entry.rank <= 3)
                            Icon(
                              Icons.trending_up_rounded,
                              color: entry.rank == 1
                                  ? AppColors.orange
                                  : AppColors.dimGray,
                              size: 20,
                            ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
