import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:octafitv2/core/constants/app_colors.dart';


/// Circular progress indicator — matches OctaUI ProgressRing.
class ProgressRing extends StatelessWidget {
  const ProgressRing({
    super.key,
    required this.value,
    this.size = 60,
    this.strokeWidth = 4,
    this.color = AppColors.blue,
    this.backgroundColor,
    this.center,
  });

  /// Progress value from 0 to 100.
  final double value;
  final double size;
  final double strokeWidth;
  final Color color;
  final Color? backgroundColor;
  final Widget? center;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final trackColor =
        backgroundColor ?? (isDark ? AppColors.glassBorder : AppColors.lightBorder);
    final clamped = value.clamp(0.0, 100.0);

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: _RingPainter(
              value: clamped,
              strokeWidth: strokeWidth,
              color: color,
              trackColor: trackColor,
            ),
          ),
          if (center != null) center!,
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.value,
    required this.strokeWidth,
    required this.color,
    required this.trackColor,
  });

  final double value;
  final double strokeWidth;
  final Color color;
  final Color trackColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);

    final sweepAngle = 2 * math.pi * (value / 100);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
