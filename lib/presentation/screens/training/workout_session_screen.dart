import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/widgets/bottom_nav_bar.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/primary_button.dart';
import 'package:octafit/core/widgets/top_bar.dart';
import 'package:octafit/features/training/domain/entities/workout_session_entity.dart';
import 'package:octafit/features/training/presentation/cubit/training_cubit.dart';
import 'package:octafit/features/training/presentation/cubit/workout_session_cubit.dart';

class WorkoutSessionScreen extends StatelessWidget {
  const WorkoutSessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrainingCubit, TrainingState>(
      builder: (context, trainingState) {
        final status = trainingState.status;
        final session = trainingState.workoutSession;

        if (status == TrainingStatus.loading ||
            status == TrainingStatus.initial) {
          return OctaScreen(
            showOrbs: true,
            safeArea: false,
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (status == TrainingStatus.error || session == null) {
          return OctaScreen(
            showOrbs: true,
            safeArea: false,
            body: Column(
              children: [
                const OctaTopBar(title: 'Workout', showBack: true),
                const Expanded(
                  child: Center(child: Text('Failed to load workout')),
                ),
              ],
            ),
          );
        }

        return BlocBuilder<WorkoutSessionCubit, WorkoutSessionState>(
          builder: (context, workoutState) {
            return _WorkoutBody(
              session: session,
              workoutState: workoutState,
            );
          },
        );
      },
    );
  }
}

class _WorkoutBody extends StatelessWidget {
  const _WorkoutBody({
    required this.session,
    required this.workoutState,
  });

  final WorkoutSessionEntity session;
  final WorkoutSessionState workoutState;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<WorkoutSessionCubit>();
    final currentIndex = workoutState.currentExerciseIndex.clamp(
      0,
      session.exercises.length - 1,
    );
    final currentExercise = session.exercises[currentIndex];
    final completedSets = workoutState.completedSets[currentIndex] ?? 0;
    final allDone = session.exercises.every((ex) {
      final idx = session.exercises.indexOf(ex);
      return (workoutState.completedSets[idx] ?? 0) >= ex.sets;
    });

    return Column(
      children: [
        OctaTopBar(
          title: session.title,
          subtitle: formatDuration(workoutState.elapsedSeconds),
          showBack: true,
          trailing: const Icon(Icons.more_horiz_rounded),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: _TimerCard(
                  label: 'Elapsed',
                  value: formatDuration(workoutState.elapsedSeconds),
                  icon: Icons.timer_rounded,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _TimerCard(
                  label: workoutState.isResting ? 'Rest' : 'Status',
                  value: workoutState.isResting
                      ? formatDuration(workoutState.restSecondsRemaining)
                      : (workoutState.isRunning ? 'Active' : 'Paused'),
                  icon: workoutState.isResting
                      ? Icons.hourglass_bottom_rounded
                      : Icons.bolt_rounded,
                  highlight: workoutState.isResting,
                ),
              ),
            ],
          ),
        ),
        if (workoutState.isResting)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: PrimaryButton(
              label: 'Skip Rest',
              variant: PrimaryButtonVariant.glass,
              onPressed: cubit.skipRest,
            ),
          ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: session.exercises.length,
            itemBuilder: (context, index) {
              final exercise = session.exercises[index];
              final done = workoutState.completedSets[index] ?? 0;
              final isCurrent = index == currentIndex;

              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: GlassCard(
                  glow: isCurrent ? GlassGlow.blue : GlassGlow.none,
                  padding: const EdgeInsets.all(14),
                  onTap: () => cubit.goToExercise(index),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: done >= exercise.sets
                              ? AppColors.green.withValues(alpha: 0.2)
                              : isCurrent
                                  ? AppColors.glassBlue
                                  : AppColors.chipInactive,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: done >= exercise.sets
                            ? const Icon(
                                Icons.check_rounded,
                                color: AppColors.green,
                                size: 20,
                              )
                            : Text(
                                '${index + 1}',
                                style: GoogleFonts.spaceGrotesk(
                                  fontWeight: FontWeight.w700,
                                  color: isCurrent
                                      ? AppColors.blue
                                      : AppColors.gray,
                                ),
                              ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              exercise.name,
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.white,
                              ),
                            ),
                            Text(
                              '${exercise.sets} sets \u00d7 ${exercise.reps} reps \u00b7 ${exercise.weight.toInt()} kg',
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                color: AppColors.gray,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '$done/${exercise.sets}',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              GlassCard(
                glow: GlassGlow.blue,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current: ${currentExercise.name}',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Set ${completedSets + 1} of ${currentExercise.sets} \u00b7 '
                      '${currentExercise.reps} reps \u00b7 ${currentExercise.weight.toInt()} kg',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppColors.gray,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      label: workoutState.isRunning ? 'Pause' : 'Start',
                      variant: PrimaryButtonVariant.blue,
                      onPressed: () {
                        if (workoutState.isRunning) {
                          cubit.pauseWorkout();
                        } else {
                          cubit.startWorkout();
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: PrimaryButton(
                      label: 'Complete Set',
                      variant: PrimaryButtonVariant.gradient,
                      onPressed: completedSets >= currentExercise.sets
                          ? null
                          : () => cubit.completeSet(
                                currentIndex,
                                currentExercise.sets,
                              ),
                    ),
                  ),
                ],
              ),
              if (allDone) ...[
                const SizedBox(height: 10),
                PrimaryButton(
                  label: 'Finish Workout',
                  variant: PrimaryButtonVariant.purple,
                  onPressed: () {
                    cubit.pauseWorkout();
                    context.push(AppRoutes.workoutComplete);
                  },
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _TimerCard extends StatelessWidget {
  const _TimerCard({
    required this.label,
    required this.value,
    required this.icon,
    this.highlight = false,
  });

  final String label;
  final String value;
  final IconData icon;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      glow: highlight ? GlassGlow.purple : GlassGlow.none,
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Icon(icon, color: highlight ? AppColors.purple : AppColors.blue, size: 22),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(fontSize: 11, color: AppColors.gray),
              ),
              Text(
                value,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
