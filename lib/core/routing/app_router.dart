import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:octafitv2/core/animations/page_transitions.dart';
import 'package:octafitv2/core/routing/app_routers.dart';
import 'package:octafitv2/features/auth/persentation/view/login_screen.dart';
import 'package:octafitv2/features/home/persentation/view/welcome_view.dart';
import 'package:octafitv2/features/onboarding/onboarding_screen.dart';
import 'package:octafitv2/splash_screen.dart';

import '../../features/auth/persentation/view/signup_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
// final _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');
final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRouters.splash,
  routes: [
    GoRoute(path: '/', redirect: (context, state) => AppRouters.splash),
    _fullScreenRoute(AppRouters.splash, const SplashScreen()),
    GoRoute(
      path: AppRouters.welcome,
      pageBuilder: (context, state) => buildOctaTransitionPage(
        state: state,
        child: const OnboardingScreen(),
      ),
    ),
    GoRoute(
      path: AppRouters.onboarding2,
      pageBuilder: (context, state) => buildOctaTransitionPage(
        state: state,
        child: const OnboardingScreen(),
      ),
    ),
    GoRoute(
      path: AppRouters.onboarding3,
      pageBuilder: (context, state) => buildOctaTransitionPage(
        state: state,
        child: const OnboardingScreen(),
      ),
    ),
    GoRoute(
      path: AppRouters.onboarding4,
      pageBuilder: (context, state) => buildOctaTransitionPage(
        state: state,
        child: const OnboardingScreen(),
      ),
    ),
    GoRoute(
      path: AppRouters.onboarding5,
      pageBuilder: (context, state) => buildOctaTransitionPage(
        state: state,
        child: const OnboardingScreen(),
      ),
    ),
    _fullScreenRoute(AppRouters.welcome, const WelcomeView()),
    _fullScreenRoute(AppRouters.signup, const SignupScreen()),
    _fullScreenRoute(AppRouters.login, const LoginScreen()),
    // for (var step = 1; step <= 8; step++)
    //  _fullScreenRoute(AppRoutes.verifyEmail, const VerifyEmailScreen()),
    // _fullScreenRoute(AppRoutes.createPassword, const CreatePasswordScreen()),
    // 
    // _fullScreenRoute(AppRoutes.forgotPassword, const ForgotPasswordScreen()),
    // _fullScreenRoute(AppRoutes.profileSetup, const ProfileSetupScreen()),
  ],
);

GoRoute _fullScreenRoute(String path, Widget child) {
  return GoRoute(
    path: path,
    parentNavigatorKey: _rootNavigatorKey,
    pageBuilder: (context, state) =>
        buildOctaTransitionPage(state: state, child: child),
  );
}
