import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafitv2/core/constants/app_colors.dart';


/// Screen header with optional back button and trailing action.
class OctaTopBar extends StatelessWidget implements PreferredSizeWidget {
  const OctaTopBar({
    super.key,
    this.title,
    this.subtitle,
    this.showBack = false,
    this.onBack,
    this.trailing,
    this.onTrailingTap,
    this.padding = const EdgeInsets.fromLTRB(20, 12, 20, 8),
  });

  final String? title;
  final String? subtitle;
  final bool showBack;
  final VoidCallback? onBack;
  final Widget? trailing;
  final VoidCallback? onTrailingTap;
  final EdgeInsetsGeometry padding;

  @override
  Size get preferredSize => Size.fromHeight(subtitle != null ? 72 : 56);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.white : AppColors.lightText;
    final subColor = isDark ? AppColors.gray : AppColors.lightGray;

    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (showBack)
              IconButton(
                onPressed: onBack ?? () => context.pop(),
                icon: Icon(Icons.chevron_left_rounded, color: textColor, size: 28),
                padding: const EdgeInsets.all(4),
                constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
              ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (title != null)
                    Text(
                      title!,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: textColor,
                      ),
                    ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: subColor,
                      ),
                    ),
                ],
              ),
            ),
            if (trailing != null)
              IconButton(
                onPressed: onTrailingTap,
                icon: IconTheme(
                  data: IconThemeData(color: textColor, size: 24),
                  child: trailing!,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
