import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/widgets/badge_widget.dart';
import 'package:octafit/core/widgets/bottom_nav_bar.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/primary_button.dart';
import 'package:octafit/core/widgets/top_bar.dart';
import 'package:octafit/features/training/presentation/cubit/training_cubit.dart';

class ExerciseDetailScreen extends StatelessWidget {
  const ExerciseDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrainingCubit, TrainingState>(
      builder: (context, state) {
        if (state.status == TrainingStatus.initial) {
          context.read<TrainingCubit>().loadExercises();
        }

        final exercise = state.selectedExercise;

        return OctaScreen(
          showOrbs: true,
          safeArea: false,
          scrollable: true,
          body: Column(
            children: [
              const OctaTopBar(title: 'Exercise Detail', showBack: true),
              if (state.status == TrainingStatus.loading)
                const Padding(
                  padding: EdgeInsets.all(48),
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (exercise == null)
                const Padding(
                  padding: EdgeInsets.all(24),
                  child: Text('Exercise not found'),
                )
              else
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GlassCard(
                        glow: GlassGlow.blue,
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                gradient: AppColors.gradBoth,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Icon(
                                Icons.fitness_center_rounded,
                                size: 40,
                                color: AppColors.white,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              exercise.name,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: AppColors.white,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BadgeWidget(
                                  label: exercise.muscle.toUpperCase(),
                                  color: BadgeColor.blue,
                                ),
                                const SizedBox(width: 8),
                                BadgeWidget(
                                  label: exercise.equipment.toUpperCase(),
                                  color: BadgeColor.purple,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          _DetailStat(label: 'Sets', value: '${exercise.sets}'),
                          const SizedBox(width: 10),
                          _DetailStat(label: 'Reps', value: exercise.reps),
                          const SizedBox(width: 10),
                          _DetailStat(label: 'Rest', value: exercise.rest),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Instructions',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ..._instructionsFor(exercise.name).map(
                        (step) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: GlassCard(
                            padding: const EdgeInsets.all(14),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${_instructionsFor(exercise.name).indexOf(step) + 1}.',
                                  style: GoogleFonts.spaceGrotesk(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.blue,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    step,
                                    style: GoogleFonts.inter(
                                      fontSize: 13,
                                      color: AppColors.gray,
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Tips',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      GlassCard(
                        glow: GlassGlow.purple,
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.lightbulb_outline_rounded,
                              color: AppColors.purple,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Keep core braced throughout the movement. '
                                'Control the eccentric phase for 2-3 seconds.',
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  color: AppColors.gray,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      PrimaryButton(
                        label: 'Add to Workout',
                        variant: PrimaryButtonVariant.gradient,
                        onPressed: () => context.push(AppRoutes.workoutSession),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  List<String> _instructionsFor(String name) {
    return [
      'Set up with proper form and brace your core.',
      'Execute the $name with controlled tempo.',
      'Maintain full range of motion on each rep.',
      'Rest ${'90s'} between sets and track your load.',
    ];
  }
}

class _DetailStat extends StatelessWidget {
  const _DetailStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GlassCard(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Text(
              value,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              ),
            ),
            Text(
              label,
              style: GoogleFonts.inter(fontSize: 11, color: AppColors.gray),
            ),
          ],
        ),
      ),
    );
  }
}
