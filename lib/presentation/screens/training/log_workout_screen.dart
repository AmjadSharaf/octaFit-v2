import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/routing/app_routes.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/input_field.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/primary_button.dart';
import 'package:octafit/core/widgets/section_header.dart';
import 'package:octafit/core/widgets/top_bar.dart';

class LoggedExercise {
  const LoggedExercise({
    required this.name,
    required this.sets,
    required this.reps,
    required this.weight,
  });

  final String name;
  final int sets;
  final int reps;
  final double weight;
}

class LogWorkoutScreen extends StatefulWidget {
  const LogWorkoutScreen({super.key});

  @override
  State<LogWorkoutScreen> createState() => _LogWorkoutScreenState();
}

class _LogWorkoutScreenState extends State<LogWorkoutScreen> {
  final _exercises = <LoggedExercise>[];
  final _nameController = TextEditingController();
  final _setsController = TextEditingController(text: '3');
  final _repsController = TextEditingController(text: '10');
  final _weightController = TextEditingController(text: '0');

  @override
  void dispose() {
    _nameController.dispose();
    _setsController.dispose();
    _repsController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _addExercise() {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    final sets = int.tryParse(_setsController.text) ?? 3;
    final reps = int.tryParse(_repsController.text) ?? 10;
    final weight = double.tryParse(_weightController.text) ?? 0;

    setState(() {
      _exercises.add(
        LoggedExercise(
          name: name,
          sets: sets,
          reps: reps,
          weight: weight,
        ),
      );
    });
    _nameController.clear();
    _setsController.text = '3';
    _repsController.text = '10';
    _weightController.text = '0';
  }

  void _removeAt(int index) {
    setState(() {
      _exercises.removeAt(index);
    });
  }

  void _clear() {
    setState(() {
      _exercises.clear();
    });
  }

  void _saveWorkout(BuildContext context) {
    if (_exercises.isEmpty) return;

    _clear();
    context.push(AppRoutes.workoutComplete);
  }

  @override
  Widget build(BuildContext context) {
    final exercises = _exercises;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.white : AppColors.lightText;
    final subColor = isDark ? AppColors.gray : AppColors.lightGray;

    return OctaScreen(
      showOrbs: true,
      safeArea: false,
      body: Column(
        children: [
          const OctaTopBar(
            title: 'Log Workout',
            subtitle: 'Manual exercise entry',
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
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InputField(
                          hint: 'Exercise name',
                          controller: _nameController,
                          prefixIcon: const Icon(Icons.fitness_center_rounded),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: InputField(
                                hint: 'Sets',
                                controller: _setsController,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: InputField(
                                hint: 'Reps',
                                controller: _repsController,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: InputField(
                                hint: 'Weight (kg)',
                                controller: _weightController,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        PrimaryButton(
                          label: 'Add Exercise',
                          icon: const Icon(
                            Icons.add_rounded,
                            color: AppColors.white,
                            size: 20,
                          ),
                          onPressed: _addExercise,
                        ),
                      ],
                    ),
                  ),
                  SectionHeader(
                    title: 'Logged Exercises',
                    actionLabel: exercises.isEmpty ? null : 'Clear',
                    onAction: exercises.isEmpty ? null : _clear,
                  ),
                  if (exercises.isEmpty)
                    GlassCard(
                      padding: const EdgeInsets.all(24),
                      child: Center(
                        child: Text(
                          'No exercises logged yet.\nAdd your first set above.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: subColor,
                            height: 1.5,
                          ),
                        ),
                      ),
                    )
                  else
                    ...exercises.asMap().entries.map(
                          (entry) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: _LoggedExerciseCard(
                              exercise: entry.value,
                              textColor: textColor,
                              subColor: subColor,
                              onRemove: () => _removeAt(entry.key),
                            ),
                          ),
                        ),
                  if (exercises.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    PrimaryButton(
                      label: 'Save Workout',
                      variant: PrimaryButtonVariant.purple,
                      onPressed: () => _saveWorkout(context),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoggedExerciseCard extends StatelessWidget {
  const _LoggedExerciseCard({
    required this.exercise,
    required this.textColor,
    required this.subColor,
    required this.onRemove,
  });

  final LoggedExercise exercise;
  final Color textColor;
  final Color subColor;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.chipInactive,
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
                    color: textColor,
                  ),
                ),
                Text(
                  '${exercise.sets} sets × ${exercise.reps} reps'
                  '${exercise.weight > 0 ? ' · ${exercise.weight} kg' : ''}',
                  style: GoogleFonts.inter(fontSize: 12, color: subColor),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onRemove,
            icon: Icon(Icons.close_rounded, color: subColor, size: 20),
          ),
        ],
      ),
    );
  }
}
