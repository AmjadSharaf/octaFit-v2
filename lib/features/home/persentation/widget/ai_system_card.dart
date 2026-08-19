


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafitv2/core/constants/app_colors.dart';
import 'package:octafitv2/core/widgets/scale_press.dart';

class AiSystemCard extends StatelessWidget {
  const AiSystemCard({
    required this.emoji,
    required this.name,
    required this.metric,
    required this.gradient,
    required this.onTap,
  });

  final String emoji;
  final String name;
  final String metric;
  final Gradient gradient;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: ScalePressWrapper(
        onTap: onTap,
        child: Container(
          width: 140,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(16),
            boxShadow: AppColors.blueGlow(blur: 16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(emoji, style: const TextStyle(fontSize: 24)),
              const Spacer(),
              Text(
                name,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                metric,
                style: GoogleFonts.inter(
                  fontSize: 10,
                  color: AppColors.white.withValues(alpha: 0.75),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}