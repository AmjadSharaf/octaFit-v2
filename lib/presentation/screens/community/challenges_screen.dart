import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/widgets/badge_widget.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/primary_button.dart';
import 'package:octafit/core/widgets/top_bar.dart';
import 'package:octafit/features/community/presentation/cubit/community_cubit.dart';

class ChallengesScreen extends StatelessWidget {
  const ChallengesScreen({super.key});

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
          const OctaTopBar(title: 'Challenges', showBack: true),
          Expanded(
            child: BlocBuilder<CommunityCubit, CommunityState>(
              builder: (context, state) {
                final challenges = state.challenges;
                return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                  itemCount: challenges.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return _ChallengeCard(
                      challenge: challenges[index],
                      textColor: textColor,
                      subColor: subColor,
                      onToggle: () => context
                          .read<CommunityCubit>()
                          .toggleChallengeJoin(challenges[index].id),
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

class _ChallengeCard extends StatelessWidget {
  const _ChallengeCard({
    required this.challenge,
    required this.textColor,
    required this.subColor,
    required this.onToggle,
  });

  final ChallengeEntry challenge;
  final Color textColor;
  final Color subColor;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      glow: challenge.joined ? GlassGlow.blue : GlassGlow.none,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(challenge.icon, style: const TextStyle(fontSize: 36)),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      challenge.title,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${challenge.participants} participants · ${challenge.daysLeft} days left',
                      style: GoogleFonts.inter(fontSize: 12, color: subColor),
                    ),
                  ],
                ),
              ),
              if (challenge.joined)
                const BadgeWidget(label: 'JOINED', color: BadgeColor.green),
            ],
          ),
          const SizedBox(height: 14),
          PrimaryButton(
            label: challenge.joined ? 'Leave Challenge' : 'Join Challenge',
            variant: challenge.joined
                ? PrimaryButtonVariant.glass
                : PrimaryButtonVariant.blue,
            fullWidth: true,
            onPressed: onToggle,
          ),
        ],
      ),
    );
  }
}
