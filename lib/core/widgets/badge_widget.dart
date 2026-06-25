import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';

/// Small colored label pill — matches OctaUI Badge.
class BadgeWidget extends StatelessWidget {
  const BadgeWidget({
    super.key,
    required this.label,
    this.color = BadgeColor.blue,
  });

  final String label;
  final BadgeColor color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.badgeBackground(color),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: GoogleFonts.spaceGrotesk(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: AppColors.badgeForeground(color),
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
