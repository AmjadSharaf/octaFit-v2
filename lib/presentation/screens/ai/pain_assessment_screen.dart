import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/routing/app_routes.dart';
import 'package:octafit/core/widgets/chip_widget.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/primary_button.dart';
import 'package:octafit/core/widgets/top_bar.dart';
import 'package:octafit/features/ai_physio/presentation/cubit/ai_physio_cubit.dart';

const _bodyAreas = [
  'Knee',
  'Lower Back',
  'Shoulder',
  'Ankle',
  'Hip',
  'Neck',
];

class PainAssessmentScreen extends StatelessWidget {
  const PainAssessmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AiPhysioCubit, AiPhysioState>(
      listenWhen: (prev, cur) =>
          prev.status != AiPhysioStatus.planReady &&
          cur.status == AiPhysioStatus.planReady,
      listener: (context, state) {
        context.push(AppRoutes.recoveryPlan);
      },
      child: BlocBuilder<AiPhysioCubit, AiPhysioState>(
        builder: (context, state) {
          final isDark = Theme.of(context).brightness == Brightness.dark;
          final textColor = isDark ? AppColors.white : AppColors.lightText;
          final subColor = isDark ? AppColors.gray : AppColors.lightGray;

          final selectedArea = state.selectedBodyArea;
          final painLevel = state.painLevel;

          final painColor = painLevel <= 3
              ? AppColors.green
              : painLevel <= 6
                  ? AppColors.orange
                  : AppColors.red;

          final painLabel = switch (painLevel.round()) {
            1 || 2 => 'Mild',
            3 || 4 => 'Moderate',
            5 || 6 => 'Significant',
            _      => 'Severe',
          };

          return OctaScreen(
            showOrbs: true,
            safeArea: false,
            body: Column(
              children: [
                const OctaTopBar(title: 'Pain Assessment', showBack: true),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GlassCard(
                          glow: GlassGlow.purple,
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Where does it hurt?',
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: textColor,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Select the primary area of discomfort.',
                                style: GoogleFonts.inter(fontSize: 13, color: subColor),
                              ),
                              const SizedBox(height: 14),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: _bodyAreas.map((area) {
                                  return ChipWidget(
                                    label: area,
                                    active: selectedArea == area,
                                    onTap: () => context
                                        .read<AiPhysioCubit>()
                                        .selectBodyArea(area),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        GlassCard(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Pain Level',
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: textColor,
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: painColor.withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      '${painLevel.round()} · $painLabel',
                                      style: GoogleFonts.spaceGrotesk(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: painColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '1 = no pain · 10 = worst imaginable',
                                style: GoogleFonts.inter(fontSize: 12, color: subColor),
                              ),
                              SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  activeTrackColor: painColor,
                                  inactiveTrackColor: painColor.withValues(alpha: 0.2),
                                  thumbColor: painColor,
                                  overlayColor: painColor.withValues(alpha: 0.15),
                                ),
                                child: Slider(
                                  value: painLevel,
                                  min: 1,
                                  max: 10,
                                  divisions: 9,
                                  label: painLevel.round().toString(),
                                  onChanged: (v) => context
                                      .read<AiPhysioCubit>()
                                      .setPainLevel(v),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: List.generate(10, (i) {
                                  final level = i + 1;
                                  final active = level == painLevel.round();
                                  return Text(
                                    '$level',
                                    style: GoogleFonts.inter(
                                      fontSize: 10,
                                      fontWeight: active ? FontWeight.w700 : FontWeight.w400,
                                      color: active ? painColor : subColor,
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        PrimaryButton(
                          label: 'Continue to Recovery Plan',
                          variant: PrimaryButtonVariant.purple,
                          icon: const Icon(Icons.arrow_forward_rounded, color: AppColors.white, size: 20),
                          onPressed: selectedArea != null
                              ? () {
                                  context
                                      .read<AiPhysioCubit>()
                                      .submitAssessment();
                                }
                              : null,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
