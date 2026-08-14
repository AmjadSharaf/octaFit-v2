import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafitv2/core/constants/app_colors.dart';
import 'package:octafitv2/core/widgets/scale_press.dart';


/// Outlined secondary button — matches OctaUI GhostBtn.
class GhostButton extends StatelessWidget {
  const GhostButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.fullWidth = true,
    this.padding = const EdgeInsets.symmetric(vertical: 15),
  });

  final String label;
  final VoidCallback? onPressed;
  final Widget? icon;
  final bool fullWidth;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor =
        isDark ? AppColors.glassBorder : AppColors.lightBorder;
    final textColor =
        isDark ? AppColors.white : AppColors.lightText;

    return ScalePressWrapper(
      enabled: onPressed != null,
      onTap: onPressed,
      child: Container(
        width: fullWidth ? double.infinity : null,
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
          children: [
            if (icon != null) ...[
              icon!,
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
