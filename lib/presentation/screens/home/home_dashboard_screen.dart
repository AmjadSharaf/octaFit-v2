import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/widgets/avatar_widget.dart';
import 'package:octafit/core/widgets/badge_widget.dart';
import 'package:octafit/core/widgets/bottom_nav_bar.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/progress_ring.dart';
import 'package:octafit/core/widgets/scale_press.dart';
import 'package:octafit/core/widgets/section_header.dart';
import 'package:octafit/core/widgets/stat_card.dart';
import 'package:octafit/features/home/domain/entities/home_data.dart';
import 'package:octafit/features/home/presentation/cubit/home_cubit.dart';

class HomeDashboardScreen extends StatelessWidget {
  const HomeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.status == HomeStatus.initial) {
          context.read<HomeCubit>().loadDashboard();
        }

        final user = state.user;
        final statsLoading = state.status == HomeStatus.loading;
        final statsLoaded = state.status == HomeStatus.loaded;

        return SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Header(
                  name: user?.name.split(' ').first ?? '',
                  initials: user?.initials ?? '',
                  streak: user?.streak ?? 0,
                  onSearch: () => context.push(AppRoutes.search),
                  onNotifications: () => context.push(AppRoutes.notifications),
                  loading: user == null,
                ),
                const SizedBox(height: 20),
                GlassCard(
                  glow: GlassGlow.blue,
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      ProgressRing(
                        value: 87,
                        size: 72,
                        strokeWidth: 6,
                        center: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '87',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: AppColors.white,
                              ),
                            ),
                            Text(
                              'Score',
                              style: GoogleFonts.inter(
                                fontSize: 8,
                                color: AppColors.gray,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Excellent Form',
                                  style: GoogleFonts.spaceGrotesk(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.white,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const BadgeWidget(
                                  label: '+4 pts',
                                  color: BadgeColor.green,
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'All 5 AI systems active. 14-day streak.',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: AppColors.gray,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'AI Ecosystem',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: AppColors.white,
                          ),
                        ),
                        Text(
                          '5 systems running · All active',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: AppColors.gray,
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () => context.go(AppRoutes.aiHub),
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
                const SizedBox(height: 12),
                SizedBox(
                  height: 130,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _AiSystemCard(
                        emoji: '\u{1F916}',
                        name: 'AI Coach',
                        metric: 'Recovery 87%',
                        gradient: AppColors.gradBlue,
                        onTap: () => context.push(AppRoutes.aiCoach),
                      ),
                      _AiSystemCard(
                        emoji: '\u{1F4F9}',
                        name: 'Motion AI',
                        metric: 'Form 78/100',
                        gradient: AppColors.gradPurple,
                        onTap: () => context.push(AppRoutes.motionAnalyzer),
                      ),
                      _AiSystemCard(
                        emoji: '\u{1FA7A}',
                        name: 'AI Physio',
                        metric: 'Risk Low',
                        gradient: const LinearGradient(
                          colors: [AppColors.orange, Color(0xFFCC4400)],
                        ),
                        onTap: () => context.push(AppRoutes.physio),
                      ),
                      _AiSystemCard(
                        emoji: '\u26A1',
                        name: 'Digital Athlete',
                        metric: 'Progress 74%',
                        gradient: AppColors.gradBoth,
                        onTap: () => context.push(AppRoutes.digitalAthlete),
                      ),
                      _AiSystemCard(
                        emoji: '\u{1F957}',
                        name: 'Nutrition AI',
                        metric: '178g / 210g',
                        gradient: const LinearGradient(
                          colors: [Color(0xFF00C853), Color(0xFF00968A)],
                        ),
                        onTap: () => context.push(AppRoutes.nutrition),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                GlassCard(
                  glow: GlassGlow.purple,
                  padding: const EdgeInsets.all(18),
                  onTap: () => context.push(AppRoutes.aiCoach),
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
                const SizedBox(height: 20),
                statsLoading
                    ? const SizedBox(height: 90)
                    : Row(
                        children: [
                          Expanded(
                            child: StatCard(
                              icon: const Icon(Icons.local_fire_department_rounded),
                              label: 'Calories',
                              value:
                                  '${(state.weeklyCalories / 1000).toStringAsFixed(1)}k',
                              color: AppColors.orange,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: StatCard(
                              icon: const Icon(Icons.fitness_center_rounded),
                              label: 'Workouts',
                              value: '${state.weeklyWorkouts}',
                              color: AppColors.blue,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: StatCard(
                              icon: const Icon(Icons.timer_rounded),
                              label: 'Hours',
                              value: '${state.weeklyHours}',
                              color: AppColors.cyan,
                            ),
                          ),
                        ],
                      ),
                const SizedBox(height: 24),
                SectionHeader(title: 'Quick Actions'),
                SizedBox(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _QuickAction(
                        icon: Icons.play_arrow_rounded,
                        label: 'Start\nWorkout',
                        gradient: AppColors.gradBlue,
                        onTap: () => context.push(AppRoutes.workoutSession),
                      ),
                      _QuickAction(
                        icon: Icons.psychology_rounded,
                        label: 'AI\nCoach',
                        gradient: AppColors.gradPurple,
                        onTap: () => context.push(AppRoutes.aiCoach),
                      ),
                      _QuickAction(
                        icon: Icons.videocam_rounded,
                        label: 'Motion\nAnalysis',
                        gradient: AppColors.gradGreenCyan,
                        onTap: () => context.push(AppRoutes.motionAnalyzer),
                      ),
                      _QuickAction(
                        icon: Icons.menu_book_rounded,
                        label: 'Exercise\nLibrary',
                        gradient: AppColors.gradBoth,
                        onTap: () => context.push(AppRoutes.exerciseLibrary),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                SectionHeader(
                  title: "Today's Plan",
                  actionLabel: 'View All',
                  onAction: () => context.go(AppRoutes.training),
                ),
                GlassCard(
                  glow: GlassGlow.blue,
                  padding: const EdgeInsets.all(18),
                  onTap: () => context.push(AppRoutes.workoutSession),
                  child: Row(
                    children: [
                      ProgressRing(
                        value: 33,
                        size: 56,
                        strokeWidth: 5,
                        center: Text(
                          '1/3',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const BadgeWidget(
                              label: 'UPPER BODY',
                              color: BadgeColor.blue,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Upper Body Power',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '45 min \u00B7 6 exercises',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: AppColors.gray,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          gradient: AppColors.gradBlue,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.play_arrow_rounded,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                SectionHeader(
                  title: 'Your Programs',
                  actionLabel: 'See All',
                  onAction: () => context.go(AppRoutes.training),
                ),
                statsLoaded
                    ? Column(
                        children: state.programs
                            .take(3)
                            .map((p) => _ProgramTile(
                                  program: p,
                                  onTap: () {
                                    context.read<HomeCubit>().selectProgram(p.id);
                                    context.push(AppRoutes.programDetail);
                                  },
                                ))
                            .toList(),
                      )
                    : const SizedBox.shrink(),
                const SizedBox(height: 24),
                SectionHeader(
                  title: 'Community Pulse',
                  actionLabel: 'Community',
                  onAction: () => context.push(AppRoutes.community),
                ),
                statsLoaded
                    ? Column(
                        children: state.posts
                            .take(2)
                            .map((post) => _CommunityPostCard(post: post))
                            .toList(),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.name,
    required this.initials,
    required this.streak,
    required this.onSearch,
    required this.onNotifications,
    this.loading = false,
  });

  final String name;
  final String initials;
  final int streak;
  final VoidCallback onSearch;
  final VoidCallback onNotifications;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const SizedBox(height: 56);
    }
    return Row(
      children: [
        AvatarWidget(initials: initials, size: 44, glow: true),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good morning, $name \u{1F44B}',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.local_fire_department_rounded,
                    size: 14,
                    color: AppColors.orange,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '$streak day streak',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: AppColors.gray,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        ScalePressWrapper(
          onTap: onSearch,
          child: const _IconBtn(icon: Icons.search_rounded),
        ),
        const SizedBox(width: 8),
        ScalePressWrapper(
          onTap: onNotifications,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              const _IconBtn(icon: Icons.notifications_outlined),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _IconBtn extends StatelessWidget {
  const _IconBtn({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.glass,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Icon(icon, color: AppColors.white, size: 20),
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.gradient,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final LinearGradient gradient;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ScalePressWrapper(
      onTap: onTap,
      child: Container(
        width: 90,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: AppColors.blueGlow(blur: 16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.white, size: 24),
            const Spacer(),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgramTile extends StatelessWidget {
  const _ProgramTile({required this.program, required this.onTap});

  final DashboardProgramSummary program;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GlassCard(
        padding: const EdgeInsets.all(14),
        onTap: onTap,
        child: Row(
          children: [
            Text(program.icon, style: const TextStyle(fontSize: 28)),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    program.title,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
                  Text(
                    program.subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: AppColors.gray,
                    ),
                  ),
                  if (program.progress > 0) ...[
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: program.progress / 100,
                        backgroundColor: AppColors.glassBorder,
                        color: AppColors.blue,
                        minHeight: 4,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: AppColors.dimGray),
          ],
        ),
      ),
    );
  }
}

class _CommunityPostCard extends StatelessWidget {
  const _CommunityPostCard({required this.post});

  final DashboardPostSummary post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GlassCard(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AvatarWidget(initials: post.avatar, size: 36),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        post.user,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        post.time,
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: AppColors.dimGray,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    post.content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: AppColors.gray,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.favorite_border, size: 14, color: AppColors.dimGray),
                      const SizedBox(width: 4),
                      Text(
                        '${post.likes}',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: AppColors.dimGray,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.chat_bubble_outline, size: 14, color: AppColors.dimGray),
                      const SizedBox(width: 4),
                      Text(
                        '${post.comments}',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: AppColors.dimGray,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AiSystemCard extends StatelessWidget {
  const _AiSystemCard({
    required this.emoji,
    required this.name,
    required this.metric,
    required this.gradient,
    required this.onTap,
  });

  final String emoji;
  final String name;
  final String metric;
  final Gradient gradient;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: ScalePressWrapper(
        onTap: onTap,
        child: Container(
          width: 140,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(16),
            boxShadow: AppColors.blueGlow(blur: 16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(emoji, style: const TextStyle(fontSize: 24)),
              const Spacer(),
              Text(
                name,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                metric,
                style: GoogleFonts.inter(
                  fontSize: 10,
                  color: AppColors.white.withValues(alpha: 0.75),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
