import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/di/injection.dart';
import 'package:octafit/core/errors/failure.dart';
import 'package:octafit/core/routing/app_routes.dart';
import 'package:octafit/core/utils/either.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/input_field.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/top_bar.dart';
import 'package:octafit/features/training/domain/entities/exercise_entity.dart';
import 'package:octafit/features/training/domain/entities/program_entity.dart';
import 'package:octafit/features/training/domain/repositories/training_repository.dart';

class SearchResults {
  const SearchResults({required this.programs, required this.exercises});

  final List<ProgramEntity> programs;
  final List<ExerciseEntity> exercises;

  bool get isEmpty => programs.isEmpty && exercises.isEmpty;
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _repository = getIt<TrainingRepository>();
  String _query = '';
  List<ProgramEntity> _allPrograms = [];
  List<ExerciseEntity> _allExercises = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final results = await Future.wait([
      _repository.getPrograms(),
      _repository.getExercises(),
    ]);
    if (mounted) {
      setState(() {
        if (results[0] is Right<Failure, List<ProgramEntity>>) {
          _allPrograms =
              (results[0] as Right<Failure, List<ProgramEntity>>).value;
        }
        if (results[1] is Right<Failure, List<ExerciseEntity>>) {
          _allExercises =
              (results[1] as Right<Failure, List<ExerciseEntity>>).value;
        }
        _isLoading = false;
      });
    }
  }

  SearchResults get _filteredResults {
    final query = _query.trim().toLowerCase();
    if (query.isEmpty) {
      return const SearchResults(programs: [], exercises: []);
    }
    return SearchResults(
      programs: _allPrograms
          .where(
            (p) =>
                p.title.toLowerCase().contains(query) ||
                p.category.toLowerCase().contains(query),
          )
          .toList(),
      exercises: _allExercises
          .where(
            (e) =>
                e.name.toLowerCase().contains(query) ||
                e.muscle.toLowerCase().contains(query),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OctaScreen(
      showOrbs: true,
      safeArea: false,
      body: Column(
        children: [
          OctaTopBar(
            title: 'Search',
            showBack: true,
            trailing: const Icon(Icons.tune_rounded),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: InputField(
              hint: 'Programs, exercises, coaches...',
              prefixIcon: const Icon(Icons.search_rounded),
              onChanged: (value) => setState(() => _query = value),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(child: _buildResults()),
        ],
      ),
    );
  }

  // Widget _buildTrending() {
  //   return ListView(
  //     padding: const EdgeInsets.symmetric(horizontal: 20),
  //     children: [
  //       Text(
  //         'Trending Searches',
  //         style: GoogleFonts.spaceGrotesk(
  //           fontSize: 15,
  //           fontWeight: FontWeight.w700,
  //           color: AppColors.white,
  //         ),
  //       ),
  //       const SizedBox(height: 12),
  //       ...['Hypertrophy', 'Deadlift', 'HIIT', 'MMA', 'Squat'].map(
  //         (term) => Padding(
  //           padding: const EdgeInsets.only(bottom: 8),
  //           child: GlassCard(
  //             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  //             onTap: () => setState(() => _query = term),
  //             child: Row(
  //               children: [
  //                 const Icon(Icons.trending_up_rounded, color: AppColors.blue, size: 20),
  //                 const SizedBox(width: 12),
  //                 Text(
  //                   term,
  //                   style: GoogleFonts.inter(
  //                     fontSize: 14,
  //                     color: AppColors.white,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildResults() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final data = _filteredResults;
    if (data.isEmpty) {
      return Center(
        child: Text(
          'No results for "$_query"',
          style: GoogleFonts.inter(color: AppColors.gray),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        if (data.programs.isNotEmpty) ...[
          Text(
            'Programs',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 10),
          ...data.programs.map(
            (p) => _ProgramResult(
              program: p,
              onTap: () {
                context.push(AppRoutes.programDetail, extra: p.id);
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
        if (data.exercises.isNotEmpty) ...[
          Text(
            'Exercises',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 10),
          ...data.exercises.map(
            (e) => _ExerciseResult(
              exercise: e,
              onTap: () {
                context.push(AppRoutes.exerciseDetail, extra: e.id);
              },
            ),
          ),
        ],
      ],
    );
  }
}

class _ProgramResult extends StatelessWidget {
  const _ProgramResult({required this.program, required this.onTap});

  final ProgramEntity program;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GlassCard(
        padding: const EdgeInsets.all(14),
        onTap: onTap,
        child: Row(
          children: [
            Text(program.icon, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 12),
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
                    program.category,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: AppColors.gray,
                    ),
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

class _ExerciseResult extends StatelessWidget {
  const _ExerciseResult({required this.exercise, required this.onTap});

  final ExerciseEntity exercise;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GlassCard(
        padding: const EdgeInsets.all(14),
        onTap: onTap,
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.glassBlue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.fitness_center_rounded,
                color: AppColors.blue,
                size: 20,
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
                    '${exercise.muscle} · ${exercise.equipment}',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: AppColors.gray,
                    ),
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
