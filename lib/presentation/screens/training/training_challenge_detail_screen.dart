import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/widgets/badge_widget.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/primary_button.dart';
import 'package:octafit/core/widgets/progress_ring.dart';
import 'package:octafit/core/widgets/section_header.dart';
import 'package:octafit/core/widgets/top_bar.dart';
import 'package:octafit/features/community/presentation/cubit/community_cubit.dart';

class TrainingChallengeDetailScreen extends StatelessWidget {
  const TrainingChallengeDetailScreen({super.key, required this.challengeId});

  final String challengeId;

  static const _rules = [
    'Complete the daily target every day',
    'Log your progress in the app',
    'No rest days during the challenge period',
    'Share your results with the community',
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.white : AppColors.lightText;
    final subColor = isDark ? AppColors.gray : AppColors.lightGray;

    return OctaScreen(
      showOrbs: true,
      safeArea: false,
      body: BlocBuilder<CommunityCubit, CommunityState>(
        builder: (context, state) {
          final challenge = state.challenges.firstWhere(
            (c) => c.id == challengeId,
            orElse: () => state.challenges.first,
          );
          final progress = challenge.joined ? 42 : 0;

          return Column(
            children: [
              const OctaTopBar(title: 'Challenge', showBack: true),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GlassCard(
                        glow: challenge.joined ? GlassGlow.blue : GlassGlow.purple,
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            Text(
                              challenge.icon,
                              style: const TextStyle(fontSize: 56),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              challenge.title,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: textColor,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${challenge.participants} participants · ${challenge.daysLeft} days left',
                              style: GoogleFonts.inter(fontSize: 13, color: subColor),
                            ),
                            if (challenge.joined) ...[
                              const SizedBox(height: 16),
                              const BadgeWidget(
                                label: 'JOINED',
                                color: BadgeColor.green,
                              ),
                            ],
                          ],
                        ),
                      ),
                      if (challenge.joined) ...[
                        const SizedBox(height: 16),
                        GlassCard(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              ProgressRing(
                                value: progress.toDouble(),
                                size: 72,
                                center: Text(
                                  '$progress%',
                                  style: GoogleFonts.spaceGrotesk(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: textColor,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Your Progress',
                                      style: GoogleFonts.spaceGrotesk(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: textColor,
                                      ),
                                    ),
                                    Text(
                                      'Keep going — you\'re on track!',
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
                      ],
                      const SectionHeader(title: 'About'),
                      GlassCard(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          _descriptionFor(challenge),
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: textColor,
                            height: 1.5,
                          ),
                        ),
                      ),
                      const SectionHeader(title: 'Rules'),
                      ..._rules.map(
                        (rule) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: GlassCard(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.check_circle_outline_rounded,
                                  color: AppColors.blue,
                                  size: 20,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    rule,
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
                      const SizedBox(height: 16),
                      PrimaryButton(
                        label: challenge.joined
                            ? 'Leave Challenge'
                            : 'Join Challenge',
                        variant: challenge.joined
                            ? PrimaryButtonVariant.glass
                            : PrimaryButtonVariant.blue,
                        onPressed: () {
                          context
                              .read<CommunityCubit>()
                              .toggleChallengeJoin(challenge.id);
                          if (!challenge.joined) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Joined ${challenge.title}!',
                                  style: GoogleFonts.inter(),
                                ),
                                backgroundColor: AppColors.blue,
                              ),
                            );
                          }
                        },
                      ),
                      if (challenge.joined) ...[
                        const SizedBox(height: 10),
                        PrimaryButton(
                          label: 'Log Today\'s Progress',
                          variant: PrimaryButtonVariant.purple,
                          onPressed: () => context.pop(),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _descriptionFor(ChallengeEntry challenge) {
    return switch (challenge.id) {
      'c1' =>
        'Push your upper body limits with 100 pushups daily. Scale reps across sets — the goal is total volume. Perfect for building chest, shoulders, and triceps endurance.',
      'c2' =>
        'Hold a plank every single day, increasing duration weekly. Core stability improves posture, reduces injury risk, and boosts performance in every lift.',
      'c3' =>
        'One squat variation every day — bodyweight, goblet, or barbell. Build leg strength and mobility with progressive overload built into the program.',
      'c4' =>
        'Hit 10,000 steps daily for cardiovascular health and recovery. Walk, jog, or combine with your regular training. Track via your phone or wearable.',
      _ =>
        'Join thousands of athletes in this community challenge. Push your limits, track progress, and earn badges along the way.',
    };
  }
}
