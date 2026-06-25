import 'package:flutter/material.dart';
import 'package:octafit/core/constants/app_colors.dart';

/// Subtle grid overlay used on splash and welcome screens.
class GridBackground extends StatelessWidget {
  const GridBackground({super.key, this.cellSize = 40});

  final double cellSize;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        painter: _GridPainter(cellSize: cellSize),
        size: Size.infinite,
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  _GridPainter({required this.cellSize});

  final double cellSize;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.blue.withValues(alpha: 0.04)
      ..strokeWidth = 1;

    for (var x = 0.0; x < size.width; x += cellSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (var y = 0.0; y < size.height; y += cellSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
