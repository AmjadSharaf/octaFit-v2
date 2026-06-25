import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';

/// Circular avatar with gradient fallback and optional glow.
class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    super.key,
    this.size = 40,
    this.imageUrl,
    this.initials,
    this.glow = false,
    this.borderWidth = 2,
  });

  final double size;
  final String? imageUrl;
  final String? initials;
  final bool glow;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor =
        isDark ? AppColors.glassBorder : AppColors.lightBorder;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: imageUrl == null ? AppColors.gradBoth : null,
        border: Border.all(color: borderColor, width: borderWidth),
        boxShadow: glow
            ? [
                BoxShadow(
                  color: AppColors.blue.withValues(alpha: 0.27),
                  blurRadius: 20,
                ),
              ]
            : null,
      ),
      clipBehavior: Clip.antiAlias,
      child: imageUrl != null
          ? Image.network(
              imageUrl!,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _InitialsFallback(
                size: size,
                initials: initials ?? 'U',
              ),
            )
          : _InitialsFallback(size: size, initials: initials ?? 'U'),
    );
  }
}

class _InitialsFallback extends StatelessWidget {
  const _InitialsFallback({
    required this.size,
    required this.initials,
  });

  final double size;
  final String initials;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        initials.toUpperCase(),
        style: GoogleFonts.spaceGrotesk(
          fontSize: size * 0.35,
          fontWeight: FontWeight.w700,
          color: AppColors.white,
        ),
      ),
    );
  }
}
