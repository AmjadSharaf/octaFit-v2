import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/widgets/chip_widget.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/primary_button.dart';
import 'package:octafit/core/widgets/top_bar.dart';
import 'package:octafit/features/ai_motion_analyzer/domain/entities/motion_analysis.dart';
import 'package:octafit/features/ai_motion_analyzer/presentation/cubit/motion_analyzer_cubit.dart';
import 'package:octafit/core/routing/app_routes.dart';

const _exercises = [
  (label: 'Barbell Squat', type: MovementType.squat),
  (label: 'Deadlift', type: MovementType.deadlift),
  (label: 'Bench Press', type: MovementType.benchPress),
  (label: 'Overhead Press', type: MovementType.overheadPress),
  (label: 'Pull-up', type: MovementType.pullUp),
];

class MotionAnalyzerScreen extends StatelessWidget {
  const MotionAnalyzerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.white : AppColors.lightText;
    final subColor = isDark ? AppColors.gray : AppColors.lightGray;

    return BlocBuilder<MotionAnalyzerCubit, MotionAnalyzerState>(
      builder: (context, state) {
        final isUploaded = state.videoPath != null;

        return OctaScreen(
          showOrbs: true,
          safeArea: false,
          body: Column(
            children: [
              const OctaTopBar(title: 'Motion Analyzer', showBack: true),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GlassCard(
                        glow: GlassGlow.blue,
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.videocam_rounded,
                              size: 48,
                              color: AppColors.blue,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Upload Exercise Video',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: textColor,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Record or upload a video of your lift. AI will analyze your form in real-time.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: subColor,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 20),
                            GlassCard(
                              onTap: () => context
                                  .read<MotionAnalyzerCubit>()
                                  .uploadVideo('squat_session.mp4'),
                              padding: const EdgeInsets.all(32),
                              borderRadius: 12,
                              child: Column(
                                children: [
                                  Icon(
                                    isUploaded
                                        ? Icons.check_circle_rounded
                                        : Icons.cloud_upload_rounded,
                                    size: 40,
                                    color: isUploaded
                                        ? AppColors.green
                                        : AppColors.purple,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    isUploaded ? state.videoPath! : 'Tap to upload video',
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: textColor,
                                    ),
                                  ),
                                  if (!isUploaded)
                                    Text(
                                      'MP4, MOV · Max 50MB',
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        color: subColor,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Select Exercise',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _exercises.map((exercise) {
                          return ChipWidget(
                            label: exercise.label,
                            active: state.movementType == exercise.type,
                            onTap: () => context
                                .read<MotionAnalyzerCubit>()
                                .selectExercise(exercise.type),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 24),
                      PrimaryButton(
                        label: 'Analyze Form',
                        variant: PrimaryButtonVariant.gradient,
                        onPressed: isUploaded
                            ? () => context.push(AppRoutes.analysisProcessing)
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
    );
  }
}
