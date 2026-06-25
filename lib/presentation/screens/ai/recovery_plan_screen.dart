import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/widgets/badge_widget.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/section_header.dart';
import 'package:octafit/core/widgets/top_bar.dart';
import 'package:octafit/features/ai_physio/presentation/cubit/ai_physio_cubit.dart';

class RecoveryPlanScreen extends StatelessWidget {
  const RecoveryPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AiPhysioCubit, AiPhysioState>(
      builder: (context, state) {
        final plan = state.rehabPlan;
        final protocol = state.dailyProtocol;

        final isDark = Theme.of(context).brightness == Brightness.dark;
        final textColor = isDark ? AppColors.white : AppColors.lightText;
        final subColor = isDark ? AppColors.gray : AppColors.lightGray;

        if (plan == null || protocol.isEmpty) {
          return OctaScreen(
            showOrbs: true,
            safeArea: false,
            body: Column(
              children: [
                const OctaTopBar(title: 'Recovery Plan', showBack: true),
                const Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(color: AppColors.purple),
                        SizedBox(height: 16),
                        Text(
                          'Generating your recovery plan...',
                          style: TextStyle(color: AppColors.gray, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return OctaScreen(
          showOrbs: true,
          safeArea: false,
          body: Column(
            children: [
              OctaTopBar(
                title: 'Recovery Plan',
                subtitle: protocol.length == 1
                    ? '1-day protocol'
                    : '${protocol.length}-day ${plan.name}',
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
                        glow: GlassGlow.purple,
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            const Icon(Icons.healing_rounded, color: AppColors.green, size: 28),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'AI-Generated Protocol',
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: textColor,
                                    ),
                                  ),
                                  Text(
                                    'Based on your pain assessment',
                                    style: GoogleFonts.inter(fontSize: 12, color: subColor),
                                  ),
                                ],
                              ),
                            ),
                            BadgeWidget(
                              label: '${protocol.length} Days',
                              color: BadgeColor.green,
                            ),
                          ],
                        ),
                      ),
                      const SectionHeader(title: 'Daily Protocol'),
                      ...protocol.map(
                        (day) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: GlassCard(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        gradient: AppColors.gradPurple,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          day.day.split(' ').last,
                                          style: GoogleFonts.spaceGrotesk(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            day.focus,
                                            style: GoogleFonts.spaceGrotesk(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                              color: textColor,
                                            ),
                                          ),
                                          Text(
                                            day.duration,
                                            style: GoogleFonts.inter(fontSize: 12, color: subColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                ...day.exercises.map(
                                  (exercise) => Padding(
                                    padding: const EdgeInsets.only(bottom: 6),
                                    child: Row(
                                      children: [
                                        Icon(Icons.check_circle_outline_rounded, size: 16, color: subColor),
                                        const SizedBox(width: 8),
                                        Text(
                                          exercise,
                                          style: GoogleFonts.inter(fontSize: 13, color: textColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
