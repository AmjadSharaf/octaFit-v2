import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/routing/app_routes.dart';
import 'package:octafit/core/widgets/scale_press.dart';

export 'package:octafit/core/routing/app_routes.dart';

enum OctaNavTab { home, training, aiHub, store, profile }

/// Five-tab bottom navigation — matches OctaUI BottomNav.
class OctaBottomNavBar extends StatelessWidget {
  const OctaBottomNavBar({
    super.key,
    required this.activeTab,
  });

  final OctaNavTab activeTab;

  static OctaNavTab tabFromPath(String path) {
    if (path.startsWith('/training')) return OctaNavTab.training;
    if (path.startsWith('/ai-hub')) return OctaNavTab.aiHub;
    if (path.startsWith('/store')) return OctaNavTab.store;
    if (path.startsWith('/profile')) return OctaNavTab.profile;
    return OctaNavTab.home;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark
        ? AppColors.bg.withValues(alpha: 0.95)
        : AppColors.lightBg2.withValues(alpha: 0.95);

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          decoration: BoxDecoration(
            color: bgColor,
            border: Border(
              top: BorderSide(
                color: isDark ? AppColors.glassBorder : AppColors.lightBorder,
              ),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
          child: SafeArea(
            top: false,
            child: Row(
              children: [
                _NavItem(
                  tab: OctaNavTab.home,
                  activeTab: activeTab,
                  icon: Icons.home_rounded,
                  label: 'Home',
                  path: AppRoutes.home,
                ),
                _NavItem(
                  tab: OctaNavTab.training,
                  activeTab: activeTab,
                  icon: Icons.fitness_center_rounded,
                  label: 'Train',
                  path: AppRoutes.training,
                ),
                _NavItem(
                  tab: OctaNavTab.aiHub,
                  activeTab: activeTab,
                  icon: Icons.psychology_rounded,
                  label: 'AI Hub',
                  path: AppRoutes.aiHub,
                ),
                _NavItem(
                  tab: OctaNavTab.store,
                  activeTab: activeTab,
                  icon: Icons.shopping_bag_rounded,
                  label: 'Store',
                  path: AppRoutes.store,
                ),
                _NavItem(
                  tab: OctaNavTab.profile,
                  activeTab: activeTab,
                  icon: Icons.person_rounded,
                  label: 'Profile',
                  path: AppRoutes.profile,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.tab,
    required this.activeTab,
    required this.icon,
    required this.label,
    required this.path,
  });

  final OctaNavTab tab;
  final OctaNavTab activeTab;
  final IconData icon;
  final String label;
  final String path;

  bool get isActive => tab == activeTab;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.blue : AppColors.dimGray;

    return Expanded(
      child: ScalePressWrapper(
        onTap: () {
          if (!isActive) context.go(path);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.blue.withValues(alpha: 0.15)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 22, color: color),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
