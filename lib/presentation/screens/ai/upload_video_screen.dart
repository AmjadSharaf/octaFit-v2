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
import 'package:octafit/features/ai_motion_analyzer/domain/entities/motion_analysis.dart';
import 'package:octafit/features/ai_motion_analyzer/presentation/cubit/motion_analyzer_cubit.dart';

const _exercises = [
  (label: 'Barbell Squat', type: MovementType.squat),
  (label: 'Deadlift', type: MovementType.deadlift),
  (label: 'Bench Press', type: MovementType.benchPress),
  (label: 'Overhead Press', type: MovementType.overheadPress),
  (label: 'Pull-up', type: MovementType.pullUp),
];

class UploadVideoScreen extends StatelessWidget {
  const UploadVideoScreen({super.key});

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
              const OctaTopBar(title: 'Upload Video', showBack: true),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: GlassCard(
                              onTap: () => context
                                  .read<MotionAnalyzerCubit>()
                                  .uploadVideo('camera_recording.mp4'),
                              padding: const EdgeInsets.symmetric(vertical: 28),
                              glow: GlassGlow.blue,
                              child: Column(
                                children: [
                                  const Icon(Icons.videocam_rounded, size: 36, color: AppColors.blue),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Record',
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: textColor,
                                    ),
                                  ),
                                  Text(
                                    'Use camera',
                                    style: GoogleFonts.inter(fontSize: 12, color: subColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: GlassCard(
                              onTap: () => context
                                  .read<MotionAnalyzerCubit>()
                                  .uploadVideo('gallery_video.mp4'),
                              padding: const EdgeInsets.symmetric(vertical: 28),
                              child: Column(
                                children: [
                                  const Icon(Icons.photo_library_rounded, size: 36, color: AppColors.purple),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Gallery',
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: textColor,
                                    ),
                                  ),
                                  Text(
                                    'Pick from library',
                                    style: GoogleFonts.inter(fontSize: 12, color: subColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      GlassCard(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Icon(
                              isUploaded
                                  ? Icons.check_circle_rounded
                                  : Icons.cloud_upload_rounded,
                              color: isUploaded ? AppColors.green : AppColors.cyan,
                              size: 32,
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    isUploaded ? state.videoPath! : 'No video selected',
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: textColor,
                                    ),
                                  ),
                                  Text(
                                    isUploaded
                                        ? 'Ready for analysis'
                                        : 'MP4, MOV · Max 50MB',
                                    style: GoogleFonts.inter(fontSize: 12, color: subColor),
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
                        label: 'Upload & Analyze',
                        variant: PrimaryButtonVariant.gradient,
                        icon: const Icon(Icons.upload_rounded, color: AppColors.white, size: 20),
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
