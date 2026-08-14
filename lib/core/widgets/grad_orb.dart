import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:octafitv2/core/constants/app_colors.dart';


/// Decorative blurred gradient orb for screen backgrounds.
class GradOrb extends StatelessWidget {
  const GradOrb({
    super.key,
    this.size = 200,
    this.left = 0,
    this.top = 0,
    this.right,
    this.bottom,
    this.color = GradOrbColor.blue,
    this.opacity = 0.3,
  });

  final double size;
  final double? left;
  final double? top;
  final double? right;
  final double? bottom;
  final GradOrbColor color;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    final baseColor = color == GradOrbColor.blue ? AppColors.blue : AppColors.purple;

    return Positioned(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      child: IgnorePointer(
        child: ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  baseColor.withValues(alpha: opacity),
                  baseColor.withValues(alpha: 0),
                ],
                stops: const [0, 0.7],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum GradOrbColor { blue, purple }
