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

class AssessmentSummaryScreen extends StatelessWidget {
  const AssessmentSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = getIt<AssessmentCubit>().state;
    final heightUnit = data.useMetric ? 'cm' : 'in';
    final weightUnit = data.useMetric ? 'kg' : 'lbs';

    return OctaScreen(
      showOrbs: true,
      scrollable: true,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Text(
            'Your Profile Summary',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Review your answers before we generate your AI blueprint.',
            style: GoogleFonts.inter(fontSize: 14, color: AppColors.gray),
          ),
          const SizedBox(height: 28),
          _SummaryCard(
            title: 'Personal',
            icon: Icons.person_outline_rounded,
            rows: [
              _SummaryRow('Name', data.name.isEmpty ? '—' : data.name),
              _SummaryRow('Gender', data.gender.isEmpty ? '—' : data.gender),
              _SummaryRow('Age', '${data.age} years'),
            ],
          ),
          _SummaryCard(
            title: 'Body Metrics',
            icon: Icons.monitor_heart_outlined,
            rows: [
              _SummaryRow('Height', '${data.height.round()} $heightUnit'),
              _SummaryRow('Weight', '${data.weight.round()} $weightUnit'),
              _SummaryRow('Body Fat', '${data.bodyFat.round()}%'),
              _SummaryRow(
                'Target Weight',
                '${data.targetWeight.round()} $weightUnit',
              ),
              _SummaryRow('BMI', data.bmi.toStringAsFixed(1)),
            ],
          ),
          _SummaryCard(
            title: 'Fitness & Goals',
            icon: Icons.fitness_center_rounded,
            rows: [
              _SummaryRow(
                'Fitness Level',
                data.fitnessLevel.isEmpty ? '—' : data.fitnessLevel,
              ),
              _SummaryRow(
                'Primary Goal',
                data.primaryGoal.isEmpty ? '—' : data.primaryGoal,
              ),
              _SummaryRow('Training Days', '${data.trainingDays} / week'),
              _SummaryRow('Session Duration', '${data.sessionDuration} min'),
            ],
          ),
          _SummaryCard(
            title: 'Health & Nutrition',
            icon: Icons.restaurant_outlined,
            rows: [
              _SummaryRow(
                'Injuries',
                data.injuries.isEmpty ? 'None' : data.injuries.join(', '),
              ),
              _SummaryRow(
                'Diet Type',
                data.dietType.isEmpty ? '—' : data.dietType,
              ),
              _SummaryRow(
                'Allergies',
                data.allergies.isEmpty ? 'None' : data.allergies.join(', '),
              ),
            ],
          ),
          _SummaryCard(
            title: 'Coaching',
            icon: Icons.psychology_outlined,
            rows: [
              _SummaryRow(
                'Style',
                data.coachingStyle.isEmpty ? '—' : data.coachingStyle,
              ),
              _SummaryRow('Notifications', data.notificationFrequency),
            ],
          ),
          const SizedBox(height: 32),
          PrimaryButton(
            label: 'Generate My AI Blueprint',
            variant: PrimaryButtonVariant.gradient,
            icon: const Icon(Icons.auto_awesome_rounded, color: AppColors.white, size: 20),
            onPressed: () => context.go(AppRoutes.aiBlueprint),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.title,
    required this.icon,
    required this.rows,
  });

  final String title;
  final IconData icon;
  final List<_SummaryRow> rows;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassCard(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: AppColors.blue),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            for (var i = 0; i < rows.length; i++) ...[
              if (i > 0) const Divider(color: AppColors.glassBorder, height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    rows[i].label,
                    style: GoogleFonts.inter(fontSize: 13, color: AppColors.gray),
                  ),
                  Flexible(
                    child: Text(
                      rows[i].value,
                      textAlign: TextAlign.right,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _SummaryRow {
  const _SummaryRow(this.label, this.value);

  final String label;
  final String value;
}

