import 'package:flutter/material.dart';
import 'package:octafitv2/core/constants/app_constants.dart';

abstract final class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 600 &&
      MediaQuery.sizeOf(context).width < 900;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width <= 900;

  static EdgeInsets padding(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= 900) return const EdgeInsets.symmetric(horizontal: 32);
    if (width >= 600) return const EdgeInsets.symmetric(horizontal: 28);
    return const EdgeInsets.symmetric(horizontal: 20);
  }

  static Widget constrain(Widget child) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: AppConstants.maxContentWidth,
        ),
        child: child,
      ),
    );
  }

  static double width(BuildContext context, double fraction) {
    return MediaQuery.sizeOf(context).width * fraction;
  }

  static double height(BuildContext context, double fraction) {
    return MediaQuery.sizeOf(context).height * fraction;
  }
}

abstract final class OctaLayout {
  static const double maxContentWidth = AppConstants.maxContentWidth;

  static bool isTablet(BuildContext context) => Responsive.isTablet(context);
  static bool isDesktop(BuildContext context) => Responsive.isDesktop(context);

  static EdgeInsets responsivePadding(BuildContext context) =>
      Responsive.padding(context);

  static Widget constrain(Widget child) => Responsive.constrain(child);
}
