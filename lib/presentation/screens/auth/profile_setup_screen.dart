import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/widgets/bottom_nav_bar.dart';
import 'package:octafit/core/widgets/chip_widget.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/primary_button.dart';
import 'package:octafit/core/routing/app_routes.dart';
import 'package:octafit/features/authentication/presentation/cubit/auth_cubit.dart';

const _goals = [
  'Build Muscle',
  'Lose Weight',
  'Get Stronger',
  'Improve Endurance',
  'Stay Active',
];

const _levels = ['Beginner', 'Intermediate', 'Advanced', 'Elite'];

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  int _step = 0;
  String _goal = 'Build Muscle';
  String _level = 'Intermediate';
  int _age = 25;
  double _weight = 75;
  double _height = 175;

  @override
  Widget build(BuildContext context) {
    return OctaScreen(
      showOrbs: true,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Row(
            children: List.generate(3, (i) {
              final active = i <= _step;
              return Expanded(
                child: Container(
                  height: 4,
                  margin: EdgeInsets.only(right: i < 2 ? 8 : 0),
                  decoration: BoxDecoration(
                    color: active ? AppColors.blue : AppColors.glassBorder,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 24),
          Text(
            _stepTitle(_step),
            style: GoogleFonts.spaceGrotesk(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _stepSubtitle(_step),
            style: GoogleFonts.inter(fontSize: 14, color: AppColors.gray),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: SingleChildScrollView(
              child: switch (_step) {
                0 => _GoalStep(
                  selected: _goal,
                  onSelect: (v) => setState(() => _goal = v),
                ),
                1 => _LevelStep(
                  selected: _level,
                  onSelect: (v) => setState(() => _level = v),
                ),
                _ => Column(
                  children: [
                    _SliderRow(
                      label: 'Age',
                      value: _age.toDouble(),
                      min: 16,
                      max: 65,
                      unit: ' yrs',
                      onChanged: (v) => setState(() => _age = v.round()),
                    ),
                    const SizedBox(height: 24),
                    _SliderRow(
                      label: 'Weight',
                      value: _weight,
                      min: 45,
                      max: 150,
                      unit: ' kg',
                      onChanged: (v) => setState(() => _weight = v),
                    ),
                    const SizedBox(height: 24),
                    _SliderRow(
                      label: 'Height',
                      value: _height,
                      min: 140,
                      max: 210,
                      unit: ' cm',
                      onChanged: (v) => setState(() => _height = v),
                    ),
                  ],
                ),
              },
            ),
          ),
          PrimaryButton(
            label: _step < 2 ? 'Continue' : 'Complete Setup',
            variant: PrimaryButtonVariant.gradient,
            onPressed: () {
              if (_step < 2) {
                setState(() => _step++);
              } else {
                // context.read<AuthCubit>().completeProfileSetup();
                context.go(AppRoutes.home);
              }
            },
          ),
          if (_step > 0) ...[
            const SizedBox(height: 12),
            Center(
              child: TextButton(
                onPressed: () => setState(() => _step--),
                child: Text(
                  'Back',
                  style: GoogleFonts.inter(fontSize: 14, color: AppColors.gray),
                ),
              ),
            ),
          ],
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  String _stepTitle(int step) => switch (step) {
    0 => "What's your goal?",
    1 => 'Your experience level',
    _ => 'About you',
  };

  String _stepSubtitle(int step) => switch (step) {
    0 => 'We\'ll personalize your training plan.',
    1 => 'This helps us calibrate intensity.',
    _ => 'Help us tailor your program.',
  };
}

class _GoalStep extends StatelessWidget {
  const _GoalStep({required this.selected, required this.onSelect});

  final String selected;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: _goals.map((goal) {
        return ChipWidget(
          label: goal,
          active: selected == goal,
          onTap: () => onSelect(goal),
        );
      }).toList(),
    );
  }
}

class _LevelStep extends StatelessWidget {
  const _LevelStep({required this.selected, required this.onSelect});

  final String selected;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _levels.map((level) {
        final active = selected == level;
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: GlassCard(
            glow: active ? GlassGlow.blue : GlassGlow.none,
            padding: const EdgeInsets.all(16),
            onTap: () => onSelect(level),
            child: Row(
              children: [
                Icon(
                  active
                      ? Icons.radio_button_checked_rounded
                      : Icons.radio_button_off_rounded,
                  color: active ? AppColors.blue : AppColors.dimGray,
                ),
                const SizedBox(width: 12),
                Text(
                  level,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _SliderRow extends StatelessWidget {
  const _SliderRow({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.unit,
    required this.onChanged,
  });

  final String label;
  final double value;
  final double min;
  final double max;
  final String unit;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.gray,
                ),
              ),
              Text(
                '${value.round()}$unit',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
          Slider(
            value: value,
            min: min,
            max: max,
            activeColor: AppColors.blue,
            inactiveColor: AppColors.glassBorder,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
