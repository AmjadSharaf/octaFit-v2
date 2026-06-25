import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/routing/app_routes.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/progress_ring.dart';
import 'package:octafit/features/ai_motion_analyzer/presentation/cubit/motion_analyzer_cubit.dart';

class AnalysisProcessingScreen extends StatefulWidget {
  const AnalysisProcessingScreen({super.key});

  @override
  State<AnalysisProcessingScreen> createState() =>
      _AnalysisProcessingScreenState();
}

class _AnalysisProcessingScreenState
    extends State<AnalysisProcessingScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final cubit = context.read<MotionAnalyzerCubit>();
      final s = cubit.state;
      if (s.videoPath != null &&
          s.status != MotionAnalyzerStatus.processing &&
          s.status != MotionAnalyzerStatus.completed) {
        cubit.startAnalysisFlow(s.videoPath!);
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MotionAnalyzerCubit, MotionAnalyzerState>(
      listenWhen: (previous, current) =>
          previous.status != MotionAnalyzerStatus.completed &&
          current.status == MotionAnalyzerStatus.completed,
      listener: (context, state) {
        context.go(AppRoutes.analysisResults);
      },
      child: BlocBuilder<MotionAnalyzerCubit, MotionAnalyzerState>(
        builder: (context, state) {
          final isDark = Theme.of(context).brightness == Brightness.dark;
          final textColor = isDark ? AppColors.white : AppColors.lightText;
          final subColor = isDark ? AppColors.gray : AppColors.lightGray;
          final progress = state.processingProgress;
          final currentStep = state.currentStep;
          final isCompleted = state.status == MotionAnalyzerStatus.completed;

          return OctaScreen(
            showOrbs: true,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ScaleTransition(
                      scale: Tween<double>(begin: 0.95, end: 1.05).animate(
                        CurvedAnimation(
                          parent: _pulseController,
                          curve: Curves.easeInOut,
                        ),
                      ),
                      child: ProgressRing(
                        value: progress,
                        size: 140,
                        strokeWidth: 6,
                        color: AppColors.blue,
                        center: Text(
                          '${progress.toInt()}%',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: textColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Analyzing Your Form',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Barbell Squat',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: AppColors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'AI is tracking joint angles, bar path,\nand stability markers...',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: subColor,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 32),
                    _ProcessingStep(
                      label: 'Detecting body landmarks',
                      done: currentStep > 0 || isCompleted,
                    ),
                    _ProcessingStep(
                      label: 'Measuring joint angles',
                      done: currentStep > 1 || isCompleted,
                    ),
                    _ProcessingStep(
                      label: 'Comparing to optimal form',
                      done: currentStep > 2 || isCompleted,
                    ),
                    _ProcessingStep(
                      label: 'Generating recommendations',
                      done: isCompleted,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}



class _ProcessingStep extends StatelessWidget {
  const _ProcessingStep({required this.label, required this.done});

  final String label;
  final bool done;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.white : AppColors.lightText;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            done ? Icons.check_circle_rounded : Icons.radio_button_unchecked,
            size: 18,
            color: done ? AppColors.green : AppColors.dimGray,
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: done ? textColor : AppColors.dimGray,
            ),
          ),
        ],
      ),
    );
  }
}
