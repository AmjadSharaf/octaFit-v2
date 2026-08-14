import 'package:flutter/material.dart';
import 'package:octafitv2/core/constants/app_colors.dart';

import 'package:octafitv2/core/widgets/grad_orb.dart';

/// Root screen wrapper with dark background and optional decorative orbs.
class OctaScreen extends StatelessWidget {
  const OctaScreen({
    super.key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.padding,
    this.showOrbs = false,
    this.scrollable = false,
    this.safeArea = true,
    this.backgroundColor,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final EdgeInsetsGeometry? padding;
  final bool showOrbs;
  final bool scrollable;
  final bool safeArea;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = backgroundColor ?? (isDark ? AppColors.bg : AppColors.lightBg);

    Widget content = padding != null ? Padding(padding: padding!, child: body) : body;

    if (scrollable) {
      content = SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: content,
      );
    }

    if (safeArea) {
      content = SafeArea(child: content);
    }

    return Scaffold(
      backgroundColor: bg,
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (showOrbs) ...[
            const GradOrb(size: 240, left: -60, top: -40, color: GradOrbColor.blue),
            const GradOrb(
              size: 200,
              right: -40,
              top: 120,
              color: GradOrbColor.purple,
              opacity: 0.25,
            ),
          ],
          content,
        ],
      ),
    );
  }
}
