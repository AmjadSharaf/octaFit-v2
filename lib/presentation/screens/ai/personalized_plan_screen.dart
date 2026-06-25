import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/widgets/badge_widget.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/primary_button.dart';
import 'package:octafit/core/widgets/section_header.dart';
import 'package:octafit/core/widgets/top_bar.dart';

class PersonalizedPlanScreen extends StatefulWidget {
  const PersonalizedPlanScreen({super.key});

  @override
  State<PersonalizedPlanScreen> createState() => _PersonalizedPlanScreenState();
}

class _PersonalizedPlanScreenState extends State<PersonalizedPlanScreen> {
  int _selectedDay = DateTime.now().weekday - 1;
  int _planVersion = 1;

  static const _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  static const _weeklyPlans = <List<({String title, String detail, String duration, BadgeColor badge})>>[
    [
      (title: 'Upper Push', detail: 'Bench Press, OHP, Dips', duration: '55 min', badge: BadgeColor.blue),
      (title: 'Mobility Flow', detail: 'Shoulder & thoracic opener', duration: '12 min', badge: BadgeColor.purple),
    ],
    [
      (title: 'Lower Strength', detail: 'Squat, RDL, Lunges', duration: '60 min', badge: BadgeColor.blue),
      (title: 'Core Stability', detail: 'Pallof press, dead bug', duration: '10 min', badge: BadgeColor.green),
    ],
    [
      (title: 'Active Recovery', detail: 'Light cardio & foam roll', duration: '30 min', badge: BadgeColor.green),
      (title: 'Hip Mobility', detail: '90/90, couch stretch', duration: '15 min', badge: BadgeColor.purple),
    ],
    [
      (title: 'Upper Pull', detail: 'Pull-ups, Rows, Face pulls', duration: '55 min', badge: BadgeColor.blue),
      (title: 'Grip Work', detail: 'Farmer carries, hangs', duration: '8 min', badge: BadgeColor.orange),
    ],
    [
      (title: 'Full Body Power', detail: 'Cleans, Box jumps, KB swings', duration: '50 min', badge: BadgeColor.blue),
      (title: 'Cooldown', detail: 'Parasympathetic breathing', duration: '8 min', badge: BadgeColor.purple),
    ],
    [
      (title: 'Conditioning', detail: 'Assault bike intervals', duration: '25 min', badge: BadgeColor.orange),
      (title: 'Yoga Reset', detail: 'Flow for recovery', duration: '20 min', badge: BadgeColor.green),
    ],
    [
      (title: 'Rest Day', detail: 'Walk, stretch, hydrate', duration: 'Light', badge: BadgeColor.green),
      (title: 'Meal Prep', detail: 'Batch protein & carbs', duration: '45 min', badge: BadgeColor.purple),
    ],
  ];

  void _regeneratePlan() {
    setState(() => _planVersion++);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Plan regenerated with AI (v$_planVersion)',
          style: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
        backgroundColor: AppColors.bg3,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.white : AppColors.lightText;
    final subColor = isDark ? AppColors.gray : AppColors.lightGray;
    final plans = _weeklyPlans[_selectedDay];

    return OctaScreen(
      showOrbs: true,
      safeArea: false,
      body: Column(
        children: [
          const OctaTopBar(title: 'Personalized Plan', showBack: true),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlassCard(
                    glow: GlassGlow.purple,
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Icon(Icons.auto_awesome_rounded, color: AppColors.purple, size: 28),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'AI-Generated Week',
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: textColor,
                                ),
                              ),
                              Text(
                                'Tailored to hypertrophy phase · v$_planVersion',
                                style: GoogleFonts.inter(fontSize: 12, color: subColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 72,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _days.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final selected = index == _selectedDay;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedDay = index),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 52,
                            decoration: BoxDecoration(
                              gradient: selected ? AppColors.gradBoth : null,
                              color: selected ? null : (isDark ? AppColors.chipInactive : AppColors.lightInputFill),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: selected ? Colors.transparent : (isDark ? AppColors.glassBorder : AppColors.lightBorder),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _days[index],
                                  style: GoogleFonts.spaceGrotesk(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: selected ? AppColors.white : subColor,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: selected ? AppColors.white : AppColors.blue.withValues(alpha: 0.5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SectionHeader(
                    title: '${_days[_selectedDay]} Plan',
                    actionLabel: 'Today',
                    onAction: () => setState(() => _selectedDay = DateTime.now().weekday - 1),
                  ),
                  ...plans.map(
                    (plan) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: GlassCard(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    plan.title,
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: textColor,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    plan.detail,
                                    style: GoogleFonts.inter(fontSize: 12, color: subColor),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                BadgeWidget(label: plan.duration, color: plan.badge),
                                const SizedBox(height: 6),
                                const Icon(Icons.chevron_right_rounded, color: AppColors.gray, size: 20),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  PrimaryButton(
                    label: 'Regenerate Plan',
                    variant: PrimaryButtonVariant.gradient,
                    icon: const Icon(Icons.refresh_rounded, color: AppColors.white, size: 20),
                    onPressed: _regeneratePlan,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
