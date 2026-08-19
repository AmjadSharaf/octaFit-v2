import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafitv2/core/constants/app_colors.dart';
import 'package:octafitv2/core/routing/app_routers.dart';
import 'package:octafitv2/core/widgets/badge_widget.dart';
import 'package:octafitv2/core/widgets/glass_card.dart';
import 'package:octafitv2/core/widgets/progress_ring.dart';
import 'package:octafitv2/features/home/persentation/manegar/home_cubit.dart';
import 'package:octafitv2/features/home/persentation/widget/ai_system_card.dart';
import 'package:octafitv2/features/home/persentation/widget/headar_widget.dart';
import 'package:octafitv2/features/home/persentation/widget/quick_action.dart';
import 'package:octafitv2/shared/custom_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.status == HomeStatus.initial) {
          context.read<HomeCubit>().loadDashboard();
        }

        final user = state.user;
        return SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeadarWidget(
                  name: user?.name.split(' ').first ?? '',
                  initials: user?.initials ?? '',
                  streak: user?.streak ?? 0,
                  onSearch: () => context.push(AppRouters.search),
                  onNotifications: () => context.push(AppRouters.notifications),
                  loading: user == null,
                ),

                const Gap(20),
                GlassCard(
                  glow: GlassGlow.blue,
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      ProgressRing(
                        value: 87,
                        size: 50,
                        strokeWidth: 4,
                        center: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomText(
                              height: 1.2,
                              text: "87",
                              color: AppColors.glassBorder,
                              size: 16,
                              fontWeight: FontWeight.w800,
                            ),
                            CustomText(
                              height: 1.2,
                              text: "Score",
                              size: 8,
                              color: AppColors.lightGray,
                            ),
                          ],
                        ),
                      ),

                      const Gap(16),
                      // ✅ Expanded يحتوي Column بدل Row متداخلة
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  // ← بدل Row بداخله
                                  child: CustomText(
                                    text: "Excellent Form ",
                                    color: AppColors.glass,
                                    fontWeight: FontWeight.w800,
                                    size: 16,

                                    maxline: 1,
                                    // overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const Gap(8),
                                const BadgeWidget(
                                  label: '+4 pts',
                                  color: BadgeColor.green,
                                ),
                              ],
                            ),
                            const Gap(6),
                            CustomText(
                              text: "All 5 AI systems active. 14-day streak.",
                              color: AppColors.lightGray,
                              size: 12,
                              maxline: 2,
                              // overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const Gap(20),
                // ✅ Expanded + Spacer لتوزيع المساحة
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText(
                            height: 1.2,
                            text: "AI Ecosystem",
                            color: AppColors.chipInactive,
                            size: 17,
                            fontWeight: FontWeight.w800,
                          ),
                          CustomText(
                            height: 1.2,
                            text: "5 systems running · All active",
                            color: AppColors.gray,
                            size: 11,
                            fontWeight: FontWeight.w800,
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () => context.go(AppRouters.notifications),
                      child: Text(
                        'AI Hub \u2192',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.blue,
                        ),
                      ),
                    ),
                  ],
                ),

                Gap(12),
                SizedBox(
                  height: 130,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      AiSystemCard(
                        emoji: '\u{1F916}',
                        name: "kdwk",
                        metric: "Recovery 87%",
                        gradient: AppColors.gradBlue,
                        onTap: () => context.push(AppRouters.search),
                      ),
                      AiSystemCard(
                        emoji: '\u{1F916}',
                        name: "kdwk",
                        metric: "Recovery 87%",
                        gradient: AppColors.gradPurple,
                        onTap: () => context.push(AppRouters.search),
                      ),
                      AiSystemCard(
                        emoji: '\u{1FA7A}',
                        name: "kdwk",
                        metric: "Recovery 87%",
                        gradient: const LinearGradient(
                          colors: [AppColors.orange, Color(0xFFCC4400)],
                        ),
                        onTap: () => context.push(AppRouters.search),
                      ),
                    ],
                  ),
                ),
                Gap(20),
                GlassCard(
                  glow: GlassGlow.purple,
                  padding: const EdgeInsets.all(18),
                  onTap: () => context.push(AppRouters.notifications),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          gradient: AppColors.gradPurple,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.auto_awesome_rounded,
                          color: AppColors.white,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'AI Insight',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.purple,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              state.aiInsight,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: AppColors.gray,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right_rounded,
                        color: AppColors.dimGray,
                      ),
                    ],
                  ),
                ),
                Gap(20),
                SizedBox(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      QuickAction(
                        icon: Icons.play_arrow_rounded,
                        label: 'Start\nWorkout',
                        gradient: AppColors.gradBlue,
                        onTap: () => context.push(AppRouters.search),
                      ),
                      QuickAction(
                        icon: Icons.psychology_rounded,
                        label: 'AI Coach',
                        gradient: AppColors.gradPurple,
                        onTap: () => context.push(AppRouters.search),
                      ),
                      QuickAction(
                        icon: Icons.videocam_rounded,
                        label: 'Motion\nAnalysis',
                        gradient: AppColors.gradGreenCyan,
                        onTap: () => context.push(AppRouters.search),
                      ),
                      QuickAction(
                        icon: Icons.menu_book_rounded,
                        label: 'Exercise\nLibrary',
                        gradient: AppColors.gradBoth,
                        onTap: () => context.push(AppRouters.search),
                      ),
                    ],
                  ),
                ),
                Gap(8),
              ],
            ),
          ),
        );
      },
    );
  }
}
