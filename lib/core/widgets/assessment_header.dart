import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';

/// Progress header for the 8-step user assessment flow.
class AssessmentHeader extends StatelessWidget {
  const AssessmentHeader({
    super.key,
    required this.step,
    this.total = 8,
    this.onBack,
  });

  final int step;
  final int total;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final progress = step / total;

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: onBack ?? () => context.pop(),
                icon: const Icon(Icons.chevron_left_rounded, size: 28),
                color: AppColors.white,
              ),
              Expanded(
                child: Text(
                  'Step $step of $total',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.gray,
                  ),
                ),
              ),
              const SizedBox(width: 48),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 4,
              backgroundColor: AppColors.glassBorder,
              valueColor: const AlwaysStoppedAnimation(AppColors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
