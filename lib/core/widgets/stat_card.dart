import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafitv2/core/constants/app_colors.dart';
import 'package:octafitv2/core/widgets/glass_card.dart';


/// Compact metric display inside a glass card — matches OctaUI StatCard.
class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.unit,
    this.color = AppColors.blue,
  });

  final Widget icon;
  final String label;
  final String value;
  final String? unit;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.white : AppColors.lightText;
    final subColor = isDark ? AppColors.gray : AppColors.lightGray;

    return GlassCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconTheme(
            data: IconThemeData(color: color, size: 22),
            child: icon,
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                  ),
                ),
                if (unit != null)
                  TextSpan(
                    text: unit,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: subColor,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11,
              color: subColor,
            ),
          ),
        ],
      ),
    );
  }
}
