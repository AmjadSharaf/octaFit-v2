import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/widgets/bottom_nav_bar.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/primary_button.dart';
import 'package:octafit/core/widgets/stat_card.dart';
import 'package:octafit/features/training/presentation/cubit/training_cubit.dart';
import 'package:octafit/features/training/presentation/cubit/workout_session_cubit.dart';

class WorkoutCompleteScreen extends StatelessWidget {
  const WorkoutCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrainingCubit, TrainingState>(
      builder: (context, trainingState) {
        final session = trainingState.workoutSession;
        return BlocBuilder<WorkoutSessionCubit, WorkoutSessionState>(
          builder: (context, workoutState) {
            final totalSets = session?.exercises.fold<int>(
                  0,
                  (sum, ex) => sum + ex.sets,
                ) ??
                0;

        final completedSets = workoutState.completedSets.values.fold<int>(
          0,
          (sum, count) => sum + count,
        );

        return OctaScreen(
          showOrbs: true,
          scrollable: true,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          body: Column(
            children: [
              const SizedBox(height: 40),
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  gradient: AppColors.gradGreenCyan,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.green.withValues(alpha: 0.3),
                      blurRadius: 30,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.emoji_events_rounded,
                  size: 44,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Workout Complete!',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 8),
              if (session != null)
                Text(
                  session.title,
                  style: GoogleFonts.inter(fontSize: 14, color: AppColors.gray),
                ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: StatCard(
                      icon: const Icon(Icons.timer_rounded),
                      label: 'Duration',
                      value: formatDuration(workoutState.elapsedSeconds),
                      color: AppColors.blue,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: StatCard(
                      icon: const Icon(Icons.fitness_center_rounded),
                      label: 'Sets Done',
                      value: '$completedSets',
                      unit: '/$totalSets',
                      color: AppColors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: StatCard(
                      icon: const Icon(Icons.local_fire_department_rounded),
                      label: 'Calories',
                      value: '${(workoutState.elapsedSeconds * 0.15).round()}',
                      color: AppColors.orange,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: StatCard(
                      icon: const Icon(Icons.trending_up_rounded),
                      label: 'Volume',
                      value: '${(completedSets * 320)}',
                      unit: ' kg',
                      color: AppColors.purple,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              GlassCard(
                glow: GlassGlow.purple,
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [
                    const Icon(Icons.auto_awesome_rounded, color: AppColors.purple),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Great session! Your recovery score improved by 3%. '
                        'Rest well and hydrate.',
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
                label: 'Back to Home',
                variant: PrimaryButtonVariant.gradient,
                onPressed: () {
                  context.read<WorkoutSessionCubit>().reset();
                  context.go(AppRoutes.home);
                },
              ),
              const SizedBox(height: 12),
              PrimaryButton(
                label: 'View Training Hub',
                variant: PrimaryButtonVariant.glass,
                onPressed: () {
                  context.read<WorkoutSessionCubit>().reset();
                  context.go(AppRoutes.training);
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  },
    );
  }
}
