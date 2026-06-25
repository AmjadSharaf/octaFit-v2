import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/routing/app_routes.dart';
import 'package:octafit/core/widgets/badge_widget.dart';
import 'package:octafit/core/widgets/chip_widget.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/progress_ring.dart';
import 'package:octafit/core/widgets/section_header.dart';
import 'package:octafit/features/training/domain/entities/program_entity.dart';
import 'package:octafit/features/training/presentation/cubit/training_cubit.dart';

class TrainingHubScreen extends StatelessWidget {
  const TrainingHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrainingCubit, TrainingState>(
      builder: (context, state) {
        if (state.status == TrainingStatus.initial) {
          context.read<TrainingCubit>().loadPrograms();
        }

        if (state.status == TrainingStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.status == TrainingStatus.error) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Failed to load programs',
                  style: GoogleFonts.inter(color: AppColors.red),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => context.read<TrainingCubit>().loadPrograms(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        final cubit = context.read<TrainingCubit>();
        final programs = cubit.filteredPrograms;

        return SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Training Hub',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Programs, workouts & exercise library',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AppColors.gray,
                  ),
                ),
                const SizedBox(height: 20),
                GlassCard(
                  glow: GlassGlow.blue,
                  padding: const EdgeInsets.all(18),
                  onTap: () => context.push(AppRoutes.workoutSession),
                  child: Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: AppColors.blue.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.play_circle_fill_rounded,
                          color: AppColors.blue,
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Quick Workout',
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppColors.white,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Start a session now',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: AppColors.gray,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right_rounded,
                        color: AppColors.gray,
                        size: 22,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                SectionHeader(
                  title: 'Programs',
                  actionLabel: 'See All',
                  onAction: () {},
                ),
                const SizedBox(height: 14),
                SizedBox(
                  height: 36,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: ['All', 'Strength', 'MMA', 'Cardio', 'Flexibility']
                        .map((label) => Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: ChipWidget(
                                label: label,
                                active: state.programFilter == label,
                                onTap: () =>
                                    context.read<TrainingCubit>().setProgramFilter(label),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 16),
                ...programs.map(
                  (p) => _ProgramCard(
                    program: p,
                    onTap: () =>
                        context.push('${AppRoutes.programDetail}/${p.id}'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ProgramCard extends StatelessWidget {
  final ProgramEntity program;
  final VoidCallback onTap;

  const _ProgramCard({required this.program, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassCard(
        onTap: onTap,
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.glass,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(
                  program.icon,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    program.title,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${program.workouts} workouts · ${program.level}',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: AppColors.gray,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (program.progress > 0)
                    ProgressRing(
                      value: program.progress.toDouble(),
                      size: 14,
                      strokeWidth: 2,
                      color: AppColors.blue,
                    ),
                ],
              ),
            ),
            BadgeWidget(
              label: '${program.rating}',
              color: BadgeColor.green,
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.gray,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
