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

class ProgramDetailScreen extends StatelessWidget {
  const ProgramDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrainingCubit, TrainingState>(
      builder: (context, state) {
        if (state.status == TrainingStatus.initial) {
          context.read<TrainingCubit>().loadPrograms();
        }

        final program = state.selectedProgram;

        return OctaScreen(
          showOrbs: true,
          safeArea: false,
          scrollable: true,
          body: Column(
            children: [
              const OctaTopBar(title: 'Program Detail', showBack: true),
              if (state.status == TrainingStatus.loading)
                const Padding(
                  padding: EdgeInsets.all(48),
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (program == null)
                const Padding(
                  padding: EdgeInsets.all(24),
                  child: Text('Program not found'),
                )
              else
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GlassCard(
                        glow: GlassGlow.purple,
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            Text(
                              program.icon,
                              style: const TextStyle(fontSize: 48),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              program.title,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: AppColors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              program.subtitle,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: AppColors.gray,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BadgeWidget(
                                  label: program.level.toUpperCase(),
                                  color: BadgeColor.purple,
                                ),
                                const SizedBox(width: 8),
                                BadgeWidget(
                                  label: program.category.toUpperCase(),
                                  color: BadgeColor.blue,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          _StatBox(
                            label: 'Duration',
                            value: program.duration,
                            icon: Icons.schedule_rounded,
                          ),
                          const SizedBox(width: 10),
                          _StatBox(
                            label: 'Workouts',
                            value: '${program.workouts}',
                            icon: Icons.fitness_center_rounded,
                          ),
                          const SizedBox(width: 10),
                          _StatBox(
                            label: 'Rating',
                            value: program.rating.toStringAsFixed(1),
                            icon: Icons.star_rounded,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'About',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'A comprehensive ${program.category.toLowerCase()} program '
                        'designed for ${program.level.toLowerCase()} athletes. '
                        'Progressive overload, structured deloads, and AI-adapted '
                        'intensity keep you on track to your goals.',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: AppColors.gray,
                          height: 1.5,
                        ),
                      ),
                      if (program.progress > 0) ...[
                        const SizedBox(height: 24),
                        Text(
                          'Your Progress',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        GlassCard(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${program.progress}% complete',
                                    style: GoogleFonts.inter(
                                      fontSize: 13,
                                      color: AppColors.gray,
                                    ),
                                  ),
                                  Text(
                                    '${(program.workouts * program.progress / 100).round()} / ${program.workouts}',
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.blue,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: program.progress / 100,
                                  backgroundColor: AppColors.glassBorder,
                                  color: AppColors.blue,
                                  minHeight: 8,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(height: 24),
                      Text(
                        'Weekly Schedule',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...['Mon — Push', 'Wed — Pull', 'Fri — Legs', 'Sat — Accessory']
                          .map(
                        (day) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: GlassCard(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.check_circle_outline_rounded,
                                  color: AppColors.blue,
                                  size: 20,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  day,
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: AppColors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      PrimaryButton(
                        label: program.progress > 0
                            ? 'Continue Program'
                            : 'Start Program',
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
}

class _StatBox extends StatelessWidget {
  const _StatBox({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GlassCard(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Icon(icon, color: AppColors.blue, size: 20),
            const SizedBox(height: 8),
            Text(
              value,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 16,
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
