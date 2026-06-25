import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/widgets/bottom_nav_bar.dart';
import 'package:octafit/core/widgets/ghost_button.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/primary_button.dart';

class OnboardingPage {
  const OnboardingPage({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.gradient,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final LinearGradient gradient;
}

const _pages = [
  OnboardingPage(
    title: 'Meet Your\nAI Coach',
    subtitle:
        'Coach OCTA learns your body, adapts your program daily, and gives you elite-level guidance — 24/7.',
    icon: Icons.smart_toy_rounded,
    gradient: AppColors.gradBlue,
  ),
  OnboardingPage(
    title: 'See Your Form\nLike Never Before',
    subtitle:
        'Motion AI detects 33 body landmarks, calculates joint angles, and corrects your technique in real time.',
    icon: Icons.videocam_rounded,
    gradient: AppColors.gradPurple,
  ),
  OnboardingPage(
    title: 'Your Personal\nAI Physiotherapist',
    subtitle:
        'Octa Physio AI detects injury risk before it happens. Get recovery protocols and mobility programs instantly.',
    icon: Icons.medical_services_rounded,
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [AppColors.orange, AppColors.red],
    ),
  ),
  OnboardingPage(
    title: 'Build Your\nDigital Athlete',
    subtitle:
        'AI creates a 3D simulation of your future physique. See where you\'ll be in 90 days.',
    icon: Icons.bolt_rounded,
    gradient: AppColors.gradBoth,
  ),
  OnboardingPage(
    title: 'Eat Like a\nChampion',
    subtitle:
        'Nutrition AI scans meals, calculates precision macros, and adapts your diet as your body changes.',
    icon: Icons.restaurant_rounded,
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF00C853), Color(0xFF00968A)],
    ),
  ),
];

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  static int pageFromPath(String path) {
    if (path == AppRoutes.onboarding2) return 1;
    if (path == AppRoutes.onboarding3) return 2;
    if (path == AppRoutes.onboarding4) return 3;
    if (path == AppRoutes.onboarding5) return 4;
    return 0;
  }

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final page = _pages[_currentPage];
    final isLast = _currentPage == _pages.length - 1;

    return OctaScreen(
      showOrbs: true,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => context.go(AppRoutes.signup),
              child: Text(
                'Skip',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.gray,
                ),
              ),
            ),
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: Column(
                key: ValueKey(_currentPage),
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: page.gradient,
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: AppColors.blueGlow(blur: 30),
                    ),
                    child: Icon(page.icon, size: 56, color: AppColors.white),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    page.title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    page.subtitle,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      height: 1.5,
                      color: AppColors.gray,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_pages.length, (i) {
              final active = i == _currentPage;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: active ? 24 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: active ? AppColors.blue : AppColors.glassBorder,
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
          const SizedBox(height: 32),
          PrimaryButton(
            label: isLast ? 'Get Started' : 'Continue',
            variant: PrimaryButtonVariant.gradient,
            onPressed: () {
              if (isLast) {
                context.go(AppRoutes.signup);
              } else {
                setState(() => _currentPage++);
              }
            },
          ),
          const SizedBox(height: 12),
          if (!isLast)
            GhostButton(
              label: 'Sign In',
              onPressed: () => context.go(AppRoutes.login),
            ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
