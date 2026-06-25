import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/widgets/scale_press.dart';

/// Glassmorphism card with optional colored glow — matches OctaUI GlassCard.
class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.margin,
    this.borderRadius = 16,
    this.glow = GlassGlow.none,
    this.width,
    this.height,
    this.color,
    this.borderColor,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final GlassGlow glow;
  final double? width;
  final double? height;
  final Color? color;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = color ??
        (isDark ? AppColors.glass : AppColors.lightGlass);
    final border = borderColor ??
        (isDark ? AppColors.glassBorder : AppColors.lightBorder);

    final glowShadows = switch (glow) {
      GlassGlow.blue => AppColors.blueGlow(),
      GlassGlow.purple => AppColors.purpleGlow(),
      GlassGlow.none => <BoxShadow>[],
    };

    Widget card = ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: width,
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: border),
            boxShadow: glowShadows,
          ),
          child: child,
        ),
      ),
    );

    if (onTap != null) {
      card = ScalePressWrapper(
        onTap: onTap,
        child: card,
      );
    }

    if (margin != null) {
      card = Padding(padding: margin!, child: card);
    }

    return card;
  }
}
