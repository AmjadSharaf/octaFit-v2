import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/routing/app_routes.dart';
import 'package:octafit/core/widgets/ghost_button.dart';
import 'package:octafit/core/widgets/grad_orb.dart';
import 'package:octafit/core/widgets/grid_background.dart';
import 'package:octafit/core/widgets/primary_button.dart';

const _features = [
  'AI Coach',
  'Motion AI',
  'Physio AI',
  'Digital Athlete',
  'Nutrition AI',
];

const _floatingBadges = [
  _FloatingBadge(
    'AI Coach',
    Icons.psychology_rounded,
    BadgeColor.blue,
    -140,
    -36,
  ),
  _FloatingBadge(
    'Motion AI',
    Icons.videocam_rounded,
    BadgeColor.purple,
    140,
    -36,
  ),
  _FloatingBadge('Physio AI', Icons.healing_rounded, BadgeColor.green, 0, 120),
];

class _FloatingBadge {
  const _FloatingBadge(this.label, this.icon, this.color, this.dx, this.dy);

  final String label;
  final IconData icon;
  final BadgeColor color;
  final double dx;
  final double dy;
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _floatController;
  late Animation<double> _floatAnim;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    )..repeat(reverse: true);
    _floatAnim = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const GridBackground(),
          const GradOrb(
            size: 280,
            left: -80,
            top: -60,
            color: GradOrbColor.blue,
          ),
          const GradOrb(
            size: 220,
            right: -50,
            bottom: 120,
            color: GradOrbColor.purple,
            opacity: 0.22,
          ),
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  SizedBox(
                    height: 260,
                    child: AnimatedBuilder(
                      animation: _floatAnim,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, _floatAnim.value),
                          child: child,
                        );
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 180,
                            height: 180,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: AppColors.gradBoth,
                              boxShadow: [
                                ...AppColors.blueGlow(blur: 48),
                                ...AppColors.purpleGlow(blur: 32),
                              ],
                            ),
                            child: const Icon(
                              Icons.fitness_center_rounded,
                              size: 72,
                              color: AppColors.white,
                            ),
                          ),
                          for (final badge in _floatingBadges)
                            Transform.translate(
                              offset: Offset(badge.dx, badge.dy),
                              child: _BadgeChip(
                                label: badge.label,
                                icon: badge.icon,
                                color: badge.color,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ShaderMask(
                    shaderCallback: (bounds) =>
                        AppColors.gradBoth.createShader(bounds),
                    child: Text(
                      'The Future of\nAthletic Performance',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        height: 1.15,
                        color: AppColors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'AI-powered trainin motion analysis and recovery  personalized for you',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: AppColors.gray,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8,
                    runSpacing: 8,
                    children: _features
                        .map(
                          (feature) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.glass,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: AppColors.glassBorder),
                            ),
                            child: Text(
                              feature,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 40),
                  PrimaryButton(
                    label: "Get Started  It's Free",
                    variant: PrimaryButtonVariant.gradient,
                    onPressed: () => context.go(AppRoutes.signup),
                  ),
                  const SizedBox(height: 12),
                  GhostButton(
                    label: 'I Already Have an Account',
                    onPressed: () => context.go(AppRoutes.login),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => context.go(AppRoutes.home),
                    child: Text(
                      'Continue as Guest',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.gray,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BadgeChip extends StatelessWidget {
  const _BadgeChip({
    required this.label,
    required this.icon,
    required this.color,
  });

  final String label;
  final IconData icon;
  final BadgeColor color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.badgeBackground(color),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.badgeForeground(color).withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.badgeForeground(color)),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.badgeForeground(color),
            ),
          ),
        ],
      ),
    );
  }
}
