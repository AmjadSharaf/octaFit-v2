import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:octafitv2/core/constants/app_colors.dart';


import 'custom_text.dart';

class CustomButtonAdd extends StatelessWidget {
  const CustomButtonAdd({
    super.key,
    required this.text,
    this.onTap,
    this.width,
    this.color,
    this.height,
    this.radius,
    this.textColor,
    this.widget,
    this.gap,
  });

  final String text;
  final Function()? onTap;
  final double? width;
  final double? height;
  final Color? color;
  final double? radius;
  final Color? textColor;
  final Widget? widget;
  final double? gap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height ?? 50,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: color ?? AppColors.white,
          borderRadius: BorderRadius.circular(radius ?? 10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget ?? SizedBox.shrink(),
            Gap(gap ?? 0.0),
            CustomText(
              text: text,
              color: textColor ?? Colors.white,
              size: 14,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}
