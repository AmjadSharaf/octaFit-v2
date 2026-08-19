import 'package:flutter/material.dart';
import 'package:octafitv2/core/constants/app_colors.dart';

class IconbtnWidget extends StatelessWidget {
  final IconData icon; 
  const IconbtnWidget({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
     return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.glass,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Icon(icon, color: AppColors.white, size: 20),
    );
  }
}
