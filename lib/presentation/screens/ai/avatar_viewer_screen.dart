import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/widgets/badge_widget.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/top_bar.dart';

class AvatarViewerScreen extends StatelessWidget {
  const AvatarViewerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.white : AppColors.lightText;

    return OctaScreen(
      showOrbs: false,
      safeArea: false,
      backgroundColor: AppColors.scaffoldDark,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF0D0D2A),
                  AppColors.bg,
                  Color(0xFF1A0A2E),
                ],
              ),
            ),
          ),
          Positioned(
            top: -80,
            left: -40,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.blue.withValues(alpha: 0.25),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            right: -60,
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.purple.withValues(alpha: 0.2),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: [
              const OctaTopBar(title: '3D Avatar', showBack: true),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) => AppColors.gradBoth.createShader(bounds),
                        blendMode: BlendMode.srcIn,
                        child: const Icon(
                          Icons.accessibility_new_rounded,
                          size: 220,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Digital Twin',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const BadgeWidget(label: '74% Complete', color: BadgeColor.blue),
                      const SizedBox(height: 16),
                      Text(
                        'Pinch to rotate · Scroll to zoom',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: AppColors.gray,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _ViewerControl(icon: Icons.rotate_right_rounded, label: 'Rotate'),
                    _ViewerControl(icon: Icons.zoom_in_rounded, label: 'Zoom'),
                    _ViewerControl(icon: Icons.layers_rounded, label: 'Layers'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ViewerControl extends StatelessWidget {
  const _ViewerControl({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: AppColors.glass,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.glassBorder),
          ),
          child: Icon(icon, color: AppColors.white, size: 24),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 11, color: AppColors.gray),
        ),
      ],
    );
  }
}
