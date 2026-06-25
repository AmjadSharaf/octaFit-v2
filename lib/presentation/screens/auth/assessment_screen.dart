import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/di/injection.dart';
import 'package:octafit/core/routing/app_routes.dart';
import 'package:octafit/core/widgets/assessment_header.dart';
import 'package:octafit/core/widgets/chip_widget.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/input_field.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/primary_button.dart';
import 'package:octafit/features/authentication/presentation/cubit/assessment_cubit.dart';

// ─── Screen ──────────────────────────────────────────────────────────────────

const _genders = ['Male', 'Female', 'Non-binary', 'Prefer not to say'];
const _avatars = [
  Icons.face_rounded,
  Icons.face_3_rounded,
  Icons.face_4_rounded,
  Icons.face_5_rounded,
  Icons.face_6_rounded,
];
const _fitnessLevels = [
  ('Beginner', 'New to structured training'),
  ('Intermediate', '1–3 years of experience'),
  ('Advanced', '3+ years, consistent training'),
  ('Athlete', 'Competitive or sport-specific'),
];
const _goals = [
  'Lose Fat',
  'Build Muscle',
  'Strength',
  'Endurance',
  'Sport',
];
const _injuries = [
  'Knee',
  'Shoulder',
  'Lower Back',
  'Ankle',
  'Wrist',
  'Hip',
  'Neck',
  'None',
];
const _dietTypes = [
  'Balanced',
  'High Protein',
  'Keto',
  'Vegan',
  'Vegetarian',
  'Paleo',
];
const _allergyOptions = [
  'Gluten',
  'Dairy',
  'Nuts',
  'Soy',
  'Eggs',
  'Shellfish',
];
const _coachingStyles = [
  'Motivational',
  'Data-Driven',
  'Gentle',
  'Intense',
];
const _notificationOptions = ['Daily', 'Weekly', 'Workout Only', 'Off'];

class AssessmentScreen extends StatefulWidget {
  const AssessmentScreen({super.key, this.step});

  final int? step;

  int _resolveStep(BuildContext context) {
    if (step != null) return step!;
    return AppRoutes.assessmentStepFromPath(GoRouterState.of(context).uri.path);
  }

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  late final TextEditingController _nameController;
  final AssessmentCubit _cubit = getIt<AssessmentCubit>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _continue(int step) {
    if (step < 8) {
      context.go(AppRoutes.assessmentPathForStep(step + 1));
    } else {
      context.go(AppRoutes.assessmentSummary);
    }
  }

  bool _canContinue(int step, AssessmentState data) => switch (step) {
        1 => data.name.trim().isNotEmpty && data.gender.isNotEmpty,
        2 => true,
        3 => data.fitnessLevel.isNotEmpty,
        4 => data.primaryGoal.isNotEmpty,
        5 => true,
        6 => true,
        7 => data.dietType.isNotEmpty,
        8 => data.coachingStyle.isNotEmpty,
        _ => false,
      };

  @override
  Widget build(BuildContext context) {
    final currentStep = widget._resolveStep(context);
    final data = _cubit.state;
    final cubit = _cubit;

    if (_nameController.text.isEmpty && data.name.isNotEmpty) {
      _nameController.text = data.name;
    }

    return OctaScreen(
      showOrbs: true,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AssessmentHeader(
            step: currentStep,
            onBack: currentStep > 1
                ? () => context.go(AppRoutes.assessmentPathForStep(currentStep - 1))
                : null,
          ),
          Text(
            _stepTitle(currentStep),
            style: GoogleFonts.spaceGrotesk(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _stepSubtitle(currentStep),
            style: GoogleFonts.inter(fontSize: 14, color: AppColors.gray),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: switch (currentStep) {
                 1 => _Step1(
                    nameController: _nameController,
                    data: data,
                    cubit: cubit,
                  ),
                 2 => _Step2(data: data, cubit: cubit),
                 3 => _Step3(data: data, cubit: cubit),
                 4 => _Step4(data: data, cubit: cubit),
                 5 => _Step5(data: data, cubit: cubit),
                 6 => _Step6(data: data, cubit: cubit),
                 7 => _Step7(data: data, cubit: cubit),
                 8 => _Step8(data: data, cubit: cubit),
                _ => const SizedBox.shrink(),
              },
            ),
          ),
          PrimaryButton(
            label: currentStep < 8 ? 'Continue' : 'Review Summary',
            variant: PrimaryButtonVariant.gradient,
            onPressed: _canContinue(currentStep, data)
                ? () => _continue(currentStep)
                : null,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  String _stepTitle(int step) => switch (step) {
        1 => 'About You',
        2 => 'Body Metrics',
        3 => 'Fitness Level',
        4 => 'Primary Goal',
        5 => 'Training Schedule',
        6 => 'Injuries & Limitations',
        7 => 'Nutrition Preferences',
        8 => 'Coaching Preferences',
        _ => '',
      };

  String _stepSubtitle(int step) => switch (step) {
        1 => 'Tell us a bit about yourself to personalize your plan.',
        2 => 'We use these to calibrate your training and nutrition.',
        3 => 'How would you describe your current fitness level?',
        4 => 'What is your main focus right now?',
        5 => 'How often and how long do you want to train?',
        6 => 'Select any areas we should account for.',
        7 => 'Help us tailor your meal recommendations.',
        8 => 'How do you want your AI coach to interact?',
        _ => '',
      };
}

// ─── Step widgets ────────────────────────────────────────────────────────────

class _Step1 extends StatelessWidget {
  const _Step1({
    required this.nameController,
    required this.data,
    required this.cubit,
  });

  final TextEditingController nameController;
  final AssessmentState data;
  final AssessmentCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputField(
          label: 'Full Name',
          hint: 'Alex Johnson',
          controller: nameController,
          prefixIcon: const Icon(Icons.person_outline_rounded),
          onChanged: cubit.setName,
        ),
        const SizedBox(height: 20),
        Text(
          'Gender',
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.gray,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _genders.map((g) {
            return ChipWidget(
              label: g,
              active: data.gender == g,
              onTap: () => cubit.setGender(g),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
        _SliderCard(
          label: 'Age',
          value: data.age.toDouble(),
          min: 16,
          max: 80,
          display: '${data.age} yrs',
          onChanged: (v) => cubit.setAge(v.round()),
        ),
        const SizedBox(height: 20),
        Text(
          'Avatar',
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.gray,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(_avatars.length, (i) {
            final active = data.avatarIndex == i;
            return GestureDetector(
              onTap: () => cubit.setAvatarIndex(i),
              child: Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: active ? AppColors.gradBlue : null,
                  color: active ? null : AppColors.inputFill,
                  border: Border.all(
                    color: active ? AppColors.blue : AppColors.glassBorder,
                  ),
                ),
                child: Icon(
                  _avatars[i],
                  color: active ? AppColors.white : AppColors.gray,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _Step2 extends StatelessWidget {
  const _Step2({required this.data, required this.cubit});

  final AssessmentState data;
  final AssessmentCubit cubit;

  @override
  Widget build(BuildContext context) {
    final heightUnit = data.useMetric ? 'cm' : 'in';
    final weightUnit = data.useMetric ? 'kg' : 'lbs';

    return Column(
      children: [
        _UnitToggle(
          useMetric: data.useMetric,
          onChanged: cubit.setUseMetric,
        ),
        const SizedBox(height: 16),
        _SliderCard(
          label: 'Height',
          value: data.height,
          min: data.useMetric ? 140 : 55,
          max: data.useMetric ? 220 : 87,
          display: '${data.height.round()} $heightUnit',
          onChanged: cubit.setHeight,
        ),
        const SizedBox(height: 16),
        _SliderCard(
          label: 'Weight',
          value: data.weight,
          min: data.useMetric ? 40 : 88,
          max: data.useMetric ? 160 : 353,
          display: '${data.weight.round()} $weightUnit',
          onChanged: cubit.setWeight,
        ),
        const SizedBox(height: 16),
        _SliderCard(
          label: 'Body Fat',
          value: data.bodyFat,
          min: 5,
          max: 45,
          display: '${data.bodyFat.round()}%',
          onChanged: cubit.setBodyFat,
        ),
        const SizedBox(height: 16),
        _SliderCard(
          label: 'Target Weight',
          value: data.targetWeight,
          min: data.useMetric ? 40 : 88,
          max: data.useMetric ? 160 : 353,
          display: '${data.targetWeight.round()} $weightUnit',
          onChanged: cubit.setTargetWeight,
        ),
        const SizedBox(height: 16),
        GlassCard(
          glow: GlassGlow.blue,
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Icon(Icons.monitor_heart_outlined, color: AppColors.blue),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'BMI Preview',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: AppColors.gray,
                      ),
                    ),
                    Text(
                      data.bmi.toStringAsFixed(1),
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                _bmiCategory(data.bmi),
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.cyan,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _bmiCategory(double bmi) {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }
}

class _Step3 extends StatelessWidget {
  const _Step3({required this.data, required this.cubit});

  final AssessmentState data;
  final AssessmentCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _fitnessLevels.map((entry) {
        final (level, subtitle) = entry;
        final active = data.fitnessLevel == level;
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: GlassCard(
            glow: active ? GlassGlow.blue : GlassGlow.none,
            padding: const EdgeInsets.all(16),
            onTap: () => cubit.setFitnessLevel(level),
            child: Row(
              children: [
                Icon(
                  active
                      ? Icons.radio_button_checked_rounded
                      : Icons.radio_button_off_rounded,
                  color: active ? AppColors.blue : AppColors.dimGray,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        level,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: GoogleFonts.inter(
                          fontSize: 12,
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
      }).toList(),
    );
  }
}

class _Step4 extends StatelessWidget {
  const _Step4({required this.data, required this.cubit});

  final AssessmentState data;
  final AssessmentCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: _goals.map((goal) {
        return ChipWidget(
          label: goal,
          active: data.primaryGoal == goal,
          onTap: () => cubit.setPrimaryGoal(goal),
        );
      }).toList(),
    );
  }
}

class _Step5 extends StatelessWidget {
  const _Step5({required this.data, required this.cubit});

  final AssessmentState data;
  final AssessmentCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SliderCard(
          label: 'Training Days per Week',
          value: data.trainingDays.toDouble(),
          min: 1,
          max: 7,
          display: '${data.trainingDays} days',
          divisions: 6,
          onChanged: (v) => cubit.setTrainingDays(v.round()),
        ),
        const SizedBox(height: 16),
        _SliderCard(
          label: 'Session Duration',
          value: data.sessionDuration.toDouble(),
          min: 20,
          max: 120,
          display: '${data.sessionDuration} min',
          divisions: 10,
          onChanged: (v) => cubit.setSessionDuration(v.round()),
        ),
      ],
    );
  }
}

class _Step6 extends StatelessWidget {
  const _Step6({required this.data, required this.cubit});

  final AssessmentState data;
  final AssessmentCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: _injuries.map((injury) {
        return ChipWidget(
          label: injury,
          active: data.injuries.contains(injury),
          onTap: () => cubit.toggleInjury(injury),
        );
      }).toList(),
    );
  }
}

class _Step7 extends StatelessWidget {
  const _Step7({required this.data, required this.cubit});

  final AssessmentState data;
  final AssessmentCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Diet Type',
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.gray,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _dietTypes.map((diet) {
            return ChipWidget(
              label: diet,
              active: data.dietType == diet,
              onTap: () => cubit.setDietType(diet),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
        Text(
          'Allergies',
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.gray,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _allergyOptions.map((allergy) {
            return ChipWidget(
              label: allergy,
              active: data.allergies.contains(allergy),
              onTap: () => cubit.toggleAllergy(allergy),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _Step8 extends StatelessWidget {
  const _Step8({required this.data, required this.cubit});

  final AssessmentState data;
  final AssessmentCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Coaching Style',
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.gray,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _coachingStyles.map((style) {
            return ChipWidget(
              label: style,
              active: data.coachingStyle == style,
              onTap: () => cubit.setCoachingStyle(style),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
        Text(
          'Notification Frequency',
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.gray,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _notificationOptions.map((freq) {
            return ChipWidget(
              label: freq,
              active: data.notificationFrequency == freq,
              onTap: () => cubit.setNotificationFrequency(freq),
            );
          }).toList(),
        ),
      ],
    );
  }
}

// ─── Shared helpers ──────────────────────────────────────────────────────────

class _UnitToggle extends StatelessWidget {
  const _UnitToggle({required this.useMetric, required this.onChanged});

  final bool useMetric;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          Expanded(
            child: _ToggleOption(
              label: 'Metric',
              active: useMetric,
              onTap: () => onChanged(true),
            ),
          ),
          Expanded(
            child: _ToggleOption(
              label: 'Imperial',
              active: !useMetric,
              onTap: () => onChanged(false),
            ),
          ),
        ],
      ),
    );
  }
}

class _ToggleOption extends StatelessWidget {
  const _ToggleOption({
    required this.label,
    required this.active,
    required this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: active ? AppColors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: active ? AppColors.white : AppColors.gray,
          ),
        ),
      ),
    );
  }
}

class _SliderCard extends StatelessWidget {
  const _SliderCard({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.display,
    required this.onChanged,
    this.divisions,
  });

  final String label;
  final double value;
  final double min;
  final double max;
  final String display;
  final ValueChanged<double> onChanged;
  final int? divisions;

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
                display,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
          Slider(
            value: value.clamp(min, max),
            min: min,
            max: max,
            divisions: divisions,
            activeColor: AppColors.blue,
            inactiveColor: AppColors.glassBorder,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

