import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/routing/app_routes.dart';
import 'package:octafit/core/widgets/chip_widget.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/input_field.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/top_bar.dart';
import 'package:octafit/features/training/domain/entities/exercise_entity.dart';
import 'package:octafit/features/training/presentation/cubit/training_cubit.dart';

class ExerciseLibraryScreen extends StatelessWidget {
  const ExerciseLibraryScreen({super.key});

  static const _filters = [
    'All',
    'Legs',
    'Chest',
    'Back',
    'Shoulders',
    'Hamstrings',
  ];

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<TrainingCubit>();
    final filter = cubit.state.exerciseFilter;
    final exercises = cubit.filteredExercises;

    return OctaScreen(
      showOrbs: true,
      safeArea: false,
      body: Column(
        children: [
          const OctaTopBar(title: 'Exercise Library', showBack: true),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: InputField(
              hint: 'Search exercises...',
              prefixIcon: const Icon(Icons.search_rounded),
              onChanged: (value) {
                cubit.setExerciseSearch(value);
              },
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 36,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: _filters
                  .map(
                    (f) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChipWidget(
                        label: f,
                        active: filter == f,
                        onTap: () => cubit.setExerciseFilter(f),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: exercises.isEmpty
                ? Center(
                    child: Text(
                      'No exercises found',
                      style: GoogleFonts.inter(color: AppColors.gray),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                    itemCount: exercises.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) => _ExerciseTile(
                      exercise: exercises[index],
                      onTap: () {
                        cubit.selectExercise(exercises[index].id);
                        context.push(AppRoutes.exerciseDetail);
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _ExerciseTile extends StatelessWidget {
  const _ExerciseTile({required this.exercise, required this.onTap});

  final ExerciseEntity exercise;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(14),
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: AppColors.gradBlue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.fitness_center_rounded,
              color: AppColors.white,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.name,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${exercise.muscle} · ${exercise.equipment}',
                  style: GoogleFonts.inter(fontSize: 12, color: AppColors.gray),
                ),
                const SizedBox(height: 4),
                Text(
                  '${exercise.sets} sets × ${exercise.reps} · Rest ${exercise.rest}',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: AppColors.dimGray,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: AppColors.dimGray),
        ],
      ),
    );
  }
}
