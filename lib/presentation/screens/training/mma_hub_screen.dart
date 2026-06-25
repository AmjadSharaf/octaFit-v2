import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/routing/app_routes.dart';
import 'package:octafit/core/widgets/badge_widget.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/section_header.dart';
import 'package:octafit/core/widgets/top_bar.dart';
import 'package:octafit/features/training/domain/entities/program_entity.dart';
import 'package:octafit/features/training/presentation/cubit/training_cubit.dart';

class MmaHubScreen extends StatelessWidget {
  const MmaHubScreen({super.key});

  static const _mmaPrograms = [
    (
      icon: '🥊',
      title: 'Striking Fundamentals',
      subtitle: 'Jab, cross, hooks & footwork',
      level: 'Beginner',
      duration: '6 weeks',
      workouts: 18,
      rating: 4.9,
    ),
    (
      icon: '🦵',
      title: 'Muay Thai Conditioning',
      subtitle: 'Kicks, knees & clinch work',
      level: 'Intermediate',
      duration: '8 weeks',
      workouts: 24,
      rating: 4.8,
    ),
    (
      icon: '🤼',
      title: 'Grappling & BJJ',
      subtitle: 'Takedowns, submissions & escapes',
      level: 'Intermediate',
      duration: '10 weeks',
      workouts: 30,
      rating: 4.7,
    ),
    (
      icon: '⚡',
      title: 'Fight Camp Prep',
      subtitle: 'Full MMA fight preparation',
      level: 'Advanced',
      duration: '12 weeks',
      workouts: 48,
      rating: 4.9,
    ),
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
          OctaTopBar(
            title: 'MMA Hub',
            subtitle: 'Striking, grappling & fight prep',
            showBack: true,
            trailing: const Icon(Icons.person_rounded),
            onTrailingTap: () => context.push(AppRoutes.fighterProfile),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlassCard(
                    glow: GlassGlow.purple,
                    padding: const EdgeInsets.all(18),
                    onTap: () => context.push(AppRoutes.workoutSession),
                    child: Row(
                      children: [
                        const Text('🥊', style: TextStyle(fontSize: 40)),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sparring Session',
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: textColor,
                                ),
                              ),
                              Text(
                                '5 rounds · Bag work & combos',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: subColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.play_circle_filled_rounded,
                          color: AppColors.purple,
                          size: 36,
                        ),
                      ],
                    ),
                  ),
                  const SectionHeader(title: 'MMA Programs'),
                  BlocBuilder<TrainingCubit, TrainingState>(
                    builder: (context, state) {
                      if (state.status == TrainingStatus.initial) {
                        context.read<TrainingCubit>().loadPrograms();
                      }
                      if (state.status == TrainingStatus.loading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final mmaPrograms =
                          state.programs.where((p) => p.category == 'MMA').toList();
                      if (mmaPrograms.isNotEmpty) {
                        return Column(
                          children: mmaPrograms
                              .map(
                                (p) => _MmaProgramCard(
                                  program: p,
                                  textColor: textColor,
                                  subColor: subColor,
                                  onTap: () {
                                    context.read<TrainingCubit>().selectProgram(p.id);
                                    context.push(AppRoutes.programDetail);
                                  },
                                ),
                              )
                              .toList(),
                        );
                      }
                      return _fallbackPrograms(context, textColor, subColor);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _fallbackPrograms(
    BuildContext context,
    Color textColor,
    Color subColor,
  ) {
    return Column(
      children: _mmaPrograms
          .map(
            (p) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GlassCard(
                padding: const EdgeInsets.all(16),
                onTap: () => context.push(AppRoutes.programDetail),
                child: Row(
                  children: [
                    Text(p.icon, style: const TextStyle(fontSize: 32)),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            p.title,
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: textColor,
                            ),
                          ),
                          Text(
                            p.subtitle,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: subColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              _MetaChip(
                                icon: Icons.schedule_rounded,
                                label: p.duration,
                              ),
                              const SizedBox(width: 8),
                              _MetaChip(
                                icon: Icons.fitness_center_rounded,
                                label: '${p.workouts} workouts',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              size: 14,
                              color: AppColors.orange,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              p.rating.toStringAsFixed(1),
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: textColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        BadgeWidget(
                          label: p.level.toUpperCase(),
                          color: BadgeColor.purple,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _MmaProgramCard extends StatelessWidget {
  const _MmaProgramCard({
    required this.program,
    required this.textColor,
    required this.subColor,
    required this.onTap,
  });

  final ProgramEntity program;
  final Color textColor;
  final Color subColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassCard(
        padding: const EdgeInsets.all(16),
        onTap: onTap,
        child: Row(
          children: [
            Text(program.icon, style: const TextStyle(fontSize: 32)),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    program.title,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                  Text(
                    program.subtitle,
                    style: GoogleFonts.inter(fontSize: 12, color: subColor),
                  ),
                ],
              ),
            ),
            BadgeWidget(
              label: program.level.toUpperCase(),
              color: BadgeColor.purple,
            ),
          ],
        ),
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.chipInactive,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: AppColors.gray),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.inter(fontSize: 11, color: AppColors.gray),
          ),
        ],
      ),
    );
  }
}

