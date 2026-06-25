import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/routing/app_routes.dart';
import 'package:octafit/core/widgets/badge_widget.dart';
import 'package:octafit/core/widgets/chip_widget.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/section_header.dart';
import 'package:octafit/core/widgets/top_bar.dart';
import 'package:octafit/features/training/domain/entities/program_entity.dart';
import 'package:octafit/features/training/presentation/cubit/training_cubit.dart';

class HomeWorkoutHubScreen extends StatelessWidget {
  const HomeWorkoutHubScreen({super.key});

  static const _filters = ['All', 'Bodyweight', 'HIIT', 'Yoga', 'Core'];
  static const _quickWorkouts = [
    (icon: '💪', title: '15-Min Full Body', duration: '15 min', level: 'Beginner'),
    (icon: '🔥', title: 'HIIT Blast', duration: '20 min', level: 'Intermediate'),
    (icon: '🧘', title: 'Morning Stretch', duration: '10 min', level: 'All Levels'),
    (icon: '⚡', title: 'Abs Crusher', duration: '12 min', level: 'Advanced'),
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
          const OctaTopBar(
            title: 'Home Workouts',
            subtitle: 'No equipment needed',
            showBack: true,
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlassCard(
                    glow: GlassGlow.blue,
                    padding: const EdgeInsets.all(18),
                    onTap: () => context.push(AppRoutes.workoutSession),
                    child: Row(
                      children: [
                        const Text('🏠', style: TextStyle(fontSize: 40)),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Start Quick Session',
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: textColor,
                                ),
                              ),
                              Text(
                                'Bodyweight only · Anywhere',
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
                          color: AppColors.blue,
                          size: 36,
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<TrainingCubit, TrainingState>(
                    builder: (context, state) {
                      final cubit = context.read<TrainingCubit>();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 36,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: _filters
                                  .map(
                                    (f) => Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: ChipWidget(
                                        label: f,
                                        active: state.programFilter == f,
                                        onTap: () => cubit.setProgramFilter(f),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const SectionHeader(title: 'Quick Workouts'),
                          ..._quickWorkouts.map(
                            (w) => Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: GlassCard(
                                padding: const EdgeInsets.all(14),
                                onTap: () => context.push(AppRoutes.workoutSession),
                                child: Row(
                                  children: [
                                    Text(w.icon, style: const TextStyle(fontSize: 28)),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            w.title,
                                            style: GoogleFonts.spaceGrotesk(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: textColor,
                                            ),
                                          ),
                                          Text(
                                            w.duration,
                                            style: GoogleFonts.inter(
                                              fontSize: 12,
                                              color: subColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    BadgeWidget(
                                      label: w.level.toUpperCase(),
                                      color: BadgeColor.blue,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SectionHeader(title: 'Programs'),
                          _buildProgramsSection(state, cubit, textColor, subColor, context),
                        ],
                      );
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

  Widget _buildProgramsSection(
    TrainingState state,
    TrainingCubit cubit,
    Color textColor,
    Color subColor,
    BuildContext context,
  ) {
    if (state.status == TrainingStatus.initial) {
      cubit.loadPrograms();
      return const SizedBox.shrink();
    }
    if (state.status == TrainingStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }
    final homePrograms = state.programs
        .where((p) => p.category == 'Home')
        .toList();
    if (homePrograms.isEmpty) {
      return _NoEquipmentCard(
        textColor: textColor,
        subColor: subColor,
      );
    }
    return Column(
      children: homePrograms
          .map(
            (p) => _HomeProgramCard(
              program: p,
              textColor: textColor,
              subColor: subColor,
              onTap: () {
                cubit.selectProgram(p.id);
                context.push(AppRoutes.programDetail);
              },
            ),
          )
          .toList(),
    );
  }
}

class _HomeProgramCard extends StatelessWidget {
  const _HomeProgramCard({
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
                    '${program.duration} · ${program.workouts} workouts',
                    style: GoogleFonts.inter(fontSize: 12, color: subColor),
                  ),
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

class _NoEquipmentCard extends StatelessWidget {
  const _NoEquipmentCard({
    required this.textColor,
    required this.subColor,
  });

  final Color textColor;
  final Color subColor;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text('🏠', style: TextStyle(fontSize: 48)),
          const SizedBox(height: 12),
          Text(
            '28-Day Home Shred',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
          Text(
            'Full body transformation with zero equipment',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(fontSize: 13, color: subColor),
          ),
        ],
      ),
    );
  }
}

