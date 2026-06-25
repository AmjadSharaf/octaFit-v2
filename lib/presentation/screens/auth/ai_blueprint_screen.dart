import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/di/injection.dart';
import 'package:octafit/core/routing/app_routes.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/primary_button.dart';
import 'package:octafit/features/authentication/presentation/cubit/assessment_cubit.dart';

class AiBlueprintScreen extends StatefulWidget {
  const AiBlueprintScreen({super.key});

  @override
  State<AiBlueprintScreen> createState() => _AiBlueprintScreenState();
}

class _AiBlueprintScreenState extends State<AiBlueprintScreen>
    with SingleTickerProviderStateMixin {
  bool _isLoading = true;
  Timer? _loadTimer;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _loadTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) setState(() => _isLoading = false);
    });
  }

  @override
  void dispose() {
    _loadTimer?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = getIt<AssessmentCubit>().state;

    return OctaScreen(
      showOrbs: true,
      scrollable: !_isLoading,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      body: _isLoading ? _buildLoading() : _buildPlan(data),
    );
  }

  Widget _buildLoading() {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.75,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Transform.scale(
                scale: 1.0 + (_pulseController.value * 0.08),
                child: child,
              );
            },
            child: Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.gradBoth,
                boxShadow: AppColors.blueGlow(blur: 40),
              ),
              child: const Icon(
                Icons.auto_awesome_rounded,
                size: 44,
                color: AppColors.white,
              ),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'Generating Your AI Blueprint',
            textAlign: TextAlign.center,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Analyzing your profile and building a personalized plan…',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(fontSize: 14, color: AppColors.gray),
          ),
          const SizedBox(height: 32),
          const SizedBox(
            width: 32,
            height: 32,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: AppColors.blue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlan(AssessmentState data) {
    final goal = data.primaryGoal.isEmpty ? 'your goals' : data.primaryGoal.toLowerCase();
    final level = data.fitnessLevel.isEmpty ? 'your level' : data.fitnessLevel.toLowerCase();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          'Your AI Blueprint',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'A personalized plan crafted for ${data.name.isEmpty ? 'you' : data.name}.',
          style: GoogleFonts.inter(fontSize: 14, color: AppColors.gray),
        ),
        const SizedBox(height: 28),
        _PlanSection(
          title: 'Training',
          icon: Icons.fitness_center_rounded,
          color: AppColors.blue,
          glow: GlassGlow.blue,
          items: [
            '${data.trainingDays}x per week · ${data.sessionDuration} min sessions',
            'Program tailored for $level athletes focusing on $goal',
            if (data.injuries.isNotEmpty && !data.injuries.contains('None'))
              'Modified exercises for: ${data.injuries.join(', ')}',
          ],
        ),
        _PlanSection(
          title: 'Nutrition',
          icon: Icons.restaurant_outlined,
          color: AppColors.green,
          glow: GlassGlow.none,
          items: [
            '${data.dietType.isEmpty ? 'Balanced' : data.dietType} meal plan',
            'Target: ${data.targetWeight.round()} ${data.useMetric ? 'kg' : 'lbs'}',
            if (data.allergies.isNotEmpty)
              'Avoiding: ${data.allergies.join(', ')}',
          ],
        ),
        _PlanSection(
          title: 'Recovery',
          icon: Icons.spa_outlined,
          color: AppColors.purple,
          glow: GlassGlow.purple,
          items: [
            '${data.coachingStyle.isEmpty ? 'Balanced' : data.coachingStyle} coaching approach',
            '${data.notificationFrequency} check-in reminders',
            'Mobility & rest days aligned with your schedule',
          ],
        ),
        const SizedBox(height: 32),
        PrimaryButton(
          label: 'Enter OctaFit',
          variant: PrimaryButtonVariant.gradient,
          onPressed: () => context.go(AppRoutes.home),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _PlanSection extends StatelessWidget {
  const _PlanSection({
    required this.title,
    required this.icon,
    required this.color,
    required this.glow,
    required this.items,
  });

  final String title;
  final IconData icon;
  final Color color;
  final GlassGlow glow;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassCard(
        glow: glow,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 22, color: color),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            for (final item in items)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.check_circle_rounded, size: 16, color: color),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        item,
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
          ],
        ),
      ),
    );
  }
}

