import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/widgets/scale_press.dart';

/// Filter chip with active state — matches OctaUI Chip.
class ChipWidget extends StatelessWidget {
  const ChipWidget({
    super.key,
    required this.label,
    this.active = false,
    this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final inactiveBg =
        isDark ? AppColors.chipInactive : AppColors.lightInputFill;
    final inactiveText = isDark ? AppColors.gray : AppColors.lightGray;

    return ScalePressWrapper(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: active ? AppColors.blue : inactiveBg,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: active ? AppColors.white : inactiveText,
          ),
        ),
      ),
    );
  }
}
