import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:octafit/core/di/injection.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/animations/page_transitions.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/widgets/bottom_nav_bar.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/top_bar.dart';
import 'package:octafit/presentation/screens/ai/ai_chat_screen.dart';
import 'package:octafit/presentation/screens/ai/ai_coach_screen.dart';
import 'package:octafit/presentation/screens/ai/ai_hub_screen.dart';
import 'package:octafit/presentation/screens/ai/analysis_processing_screen.dart';
import 'package:octafit/presentation/screens/ai/analysis_results_screen.dart';
import 'package:octafit/presentation/screens/ai/motion_analyzer_screen.dart';
import 'package:octafit/presentation/screens/ai/avatar_viewer_screen.dart';
import 'package:octafit/presentation/screens/ai/consultation_form_screen.dart';
import 'package:octafit/presentation/screens/ai/digital_athlete_hub_screen.dart';
import 'package:octafit/presentation/screens/ai/habit_tracker_screen.dart';
import 'package:octafit/presentation/screens/ai/mobility_hub_screen.dart';
import 'package:octafit/presentation/screens/ai/movement_history_screen.dart';
import 'package:octafit/presentation/screens/ai/nutrition_screen.dart';
import 'package:octafit/presentation/screens/ai/pain_assessment_screen.dart';
import 'package:octafit/presentation/screens/ai/personalized_plan_screen.dart';
import 'package:octafit/presentation/screens/ai/physio_screen.dart';
import 'package:octafit/presentation/screens/ai/predictions_screen.dart';
import 'package:octafit/presentation/screens/ai/recovery_plan_screen.dart';
import 'package:octafit/presentation/screens/ai/transformation_timeline_screen.dart';
import 'package:octafit/presentation/screens/ai/upload_video_screen.dart';
import 'package:octafit/features/ai_motion_analyzer/presentation/cubit/motion_analyzer_cubit.dart';
import 'package:octafit/features/ai_physio/presentation/cubit/ai_physio_cubit.dart';
import 'package:octafit/presentation/screens/auth/ai_blueprint_screen.dart';
import 'package:octafit/presentation/screens/auth/assessment_screen.dart';
import 'package:octafit/presentation/screens/auth/assessment_summary_screen.dart';
import 'package:octafit/presentation/screens/auth/create_password_screen.dart';
import 'package:octafit/presentation/screens/auth/forgot_password_screen.dart';
import 'package:octafit/presentation/screens/auth/login_screen.dart';
import 'package:octafit/presentation/screens/auth/profile_setup_screen.dart';
import 'package:octafit/presentation/screens/auth/signup_screen.dart';
import 'package:octafit/presentation/screens/auth/verify_email_screen.dart';
import 'package:octafit/presentation/screens/auth/welcome_screen.dart';
import 'package:octafit/presentation/screens/community/achievements_screen.dart';
import 'package:octafit/presentation/screens/community/challenges_screen.dart';
import 'package:octafit/presentation/screens/community/community_events_screen.dart';
import 'package:octafit/presentation/screens/community/community_feed_screen.dart';
import 'package:octafit/features/community/presentation/cubit/community_cubit.dart';
import 'package:octafit/presentation/screens/community/create_post_screen.dart';
import 'package:octafit/presentation/screens/community/leaderboard_screen.dart';
import 'package:octafit/presentation/screens/community/milestones_screen.dart';
import 'package:octafit/presentation/screens/community/sports_groups_screen.dart';
import 'package:octafit/presentation/screens/community/user_profile_screen.dart';
import 'package:octafit/presentation/screens/home/home_dashboard_screen.dart';
import 'package:octafit/features/home/presentation/cubit/home_cubit.dart';
import 'package:octafit/presentation/screens/home/notifications_screen.dart';
import 'package:octafit/presentation/screens/home/search_screen.dart';
import 'package:octafit/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:octafit/presentation/screens/profile/edit_profile_screen.dart';
import 'package:octafit/presentation/screens/profile/membership_screen.dart';
import 'package:octafit/presentation/screens/profile/profile_screen.dart';
import 'package:octafit/presentation/screens/profile/settings_screen.dart';
import 'package:octafit/presentation/screens/profile/subscription_paywall_screen.dart';
import 'package:octafit/presentation/screens/splash/splash_screen.dart';
import 'package:octafit/presentation/screens/store/cart_screen.dart';
import 'package:octafit/presentation/screens/store/category_browse_screen.dart';
import 'package:octafit/presentation/screens/store/checkout_address_screen.dart';
import 'package:octafit/presentation/screens/store/checkout_payment_screen.dart';
import 'package:octafit/presentation/screens/store/checkout_review_screen.dart';
import 'package:octafit/presentation/screens/store/order_success_screen.dart';
import 'package:octafit/presentation/screens/store/order_tracking_screen.dart';
import 'package:octafit/presentation/screens/store/product_detail_screen.dart';
import 'package:octafit/presentation/screens/store/store_home_screen.dart';
import 'package:octafit/features/marketplace/presentation/cubit/marketplace_cubit.dart';
import 'package:octafit/presentation/screens/store/wishlist_screen.dart';
import 'package:octafit/presentation/screens/training/exercise_detail_screen.dart';
import 'package:octafit/presentation/screens/training/exercise_library_screen.dart';
import 'package:octafit/presentation/screens/training/fighter_profile_screen.dart';
import 'package:octafit/presentation/screens/training/home_workout_hub_screen.dart';
import 'package:octafit/presentation/screens/training/log_workout_screen.dart';
import 'package:octafit/presentation/screens/training/mma_hub_screen.dart';
import 'package:octafit/presentation/screens/training/program_detail_screen.dart';
import 'package:octafit/presentation/screens/training/training_challenge_detail_screen.dart';
import 'package:octafit/presentation/screens/training/training_hub_screen.dart';
import 'package:octafit/features/training/presentation/cubit/training_cubit.dart';
import 'package:octafit/features/training/presentation/cubit/workout_session_cubit.dart';
import 'package:octafit/presentation/screens/training/workout_complete_screen.dart';
import 'package:octafit/presentation/screens/training/workout_session_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: '/',
      redirect: (_, __) => AppRoutes.splash,
    ),

    _fullScreenRoute(AppRoutes.splash, const SplashScreen()),
    GoRoute(
      path: AppRoutes.onboarding1,
      pageBuilder: (context, state) => buildOctaTransitionPage(
        state: state,
        child: const OnboardingScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.onboarding2,
      pageBuilder: (context, state) => buildOctaTransitionPage(
        state: state,
        child: const OnboardingScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.onboarding3,
      pageBuilder: (context, state) => buildOctaTransitionPage(
        state: state,
        child: const OnboardingScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.onboarding4,
      pageBuilder: (context, state) => buildOctaTransitionPage(
        state: state,
        child: const OnboardingScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.onboarding5,
      pageBuilder: (context, state) => buildOctaTransitionPage(
        state: state,
        child: const OnboardingScreen(),
      ),
    ),
    _fullScreenRoute(AppRoutes.welcome, const WelcomeScreen()),
    _fullScreenRoute(AppRoutes.signup, const SignupScreen()),
    _fullScreenRoute(AppRoutes.verifyEmail, const VerifyEmailScreen()),
    _fullScreenRoute(AppRoutes.createPassword, const CreatePasswordScreen()),
    _fullScreenRoute(AppRoutes.login, const LoginScreen()),
    _fullScreenRoute(AppRoutes.forgotPassword, const ForgotPasswordScreen()),
    _fullScreenRoute(AppRoutes.profileSetup, const ProfileSetupScreen()),
    for (var step = 1; step <= 8; step++)
      _fullScreenRoute(
        AppRoutes.assessmentPathForStep(step),
        AssessmentScreen(step: step),
      ),
    _fullScreenRoute(
      AppRoutes.assessmentSummary,
      const AssessmentSummaryScreen(),
    ),
    _fullScreenRoute(AppRoutes.aiBlueprint, const AiBlueprintScreen()),

    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => _OctaShell(
        location: state.uri.path,
        child: child,
      ),
      routes: [
        _shellRoute(
          AppRoutes.home,
          BlocProvider<HomeCubit>(
            create: (_) => sl<HomeCubit>(),
            child: const HomeDashboardScreen(),
          ),
        ),
        _shellRoute(
          AppRoutes.training,
          BlocProvider.value(
            value: sl<TrainingCubit>(),
            child: const TrainingHubScreen(),
          ),
        ),
        _shellRoute(AppRoutes.aiHub, const AiHubScreen()),
        _shellRoute(
          AppRoutes.store,
          BlocProvider<MarketplaceCubit>(
            create: (_) => sl<MarketplaceCubit>(),
            child: const StoreHomeScreen(),
          ),
        ),
        _shellRoute(AppRoutes.profile, const ProfileScreen()),
      ],
    ),

    _fullScreenRoute(AppRoutes.search, const SearchScreen()),
    _fullScreenRoute(AppRoutes.notifications, const NotificationsScreen()),

    _fullScreenRoute(
      AppRoutes.programDetail,
      BlocProvider.value(
        value: sl<TrainingCubit>(),
        child: const ProgramDetailScreen(),
      ),
    ),
    _fullScreenRoute(
      AppRoutes.workoutSession,
      MultiBlocProvider(
        providers: [
          BlocProvider<TrainingCubit>(
            create: (_) {
              final cubit = sl<TrainingCubit>();
              cubit.loadWorkoutSession();
              return cubit;
            },
          ),
          BlocProvider<WorkoutSessionCubit>(
            create: (_) => sl<WorkoutSessionCubit>(),
          ),
        ],
        child: const WorkoutSessionScreen(),
      ),
    ),
    _fullScreenRoute(
      AppRoutes.workoutComplete,
      MultiBlocProvider(
        providers: [
          BlocProvider<TrainingCubit>(
            create: (_) {
              final cubit = sl<TrainingCubit>();
              cubit.loadWorkoutSession();
              return cubit;
            },
          ),
          BlocProvider<WorkoutSessionCubit>(
            create: (_) => sl<WorkoutSessionCubit>(),
          ),
        ],
        child: const WorkoutCompleteScreen(),
      ),
    ),
    _fullScreenRoute(
      AppRoutes.exerciseLibrary,
      BlocProvider.value(
        value: sl<TrainingCubit>(),
        child: const ExerciseLibraryScreen(),
      ),
    ),
    _fullScreenRoute(
      AppRoutes.exerciseDetail,
      BlocProvider.value(
        value: sl<TrainingCubit>(),
        child: const ExerciseDetailScreen(),
      ),
    ),
    _fullScreenRoute(
      AppRoutes.logWorkout,
      BlocProvider.value(
        value: sl<TrainingCubit>(),
        child: const LogWorkoutScreen(),
      ),
    ),
    _fullScreenRoute(
      AppRoutes.mmaHub,
      BlocProvider.value(
        value: sl<TrainingCubit>(),
        child: const MmaHubScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.fighterProfile,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        final name = state.uri.queryParameters['name'];
        return buildOctaTransitionPage(
          state: state,
          child: FighterProfileScreen(fighterName: name),
        );
      },
    ),
    _fullScreenRoute(
      AppRoutes.homeWorkout,
      BlocProvider.value(
        value: sl<TrainingCubit>(),
        child: const HomeWorkoutHubScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.challengeDetail,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        final id = state.uri.queryParameters['id'] ?? 'c1';
        return buildOctaTransitionPage(
          state: state,
          child: BlocProvider.value(
            value: sl<CommunityCubit>(),
            child: TrainingChallengeDetailScreen(challengeId: id),
          ),
        );
      },
    ),

    _fullScreenRoute(AppRoutes.aiCoach, const AiCoachScreen()),
    _fullScreenRoute(AppRoutes.aiChat, const AiChatScreen()),
    _fullScreenRoute(AppRoutes.personalizedPlan, const PersonalizedPlanScreen()),
    _fullScreenRoute(AppRoutes.nutrition, const NutritionScreen()),
    _fullScreenRoute(AppRoutes.habitTracker, const HabitTrackerScreen()),
    _fullScreenRoute(
      AppRoutes.motionAnalyzer,
      BlocProvider<MotionAnalyzerCubit>(
        create: (_) => sl<MotionAnalyzerCubit>(),
        child: const MotionAnalyzerScreen(),
      ),
    ),
    _fullScreenRoute(
      AppRoutes.uploadVideo,
      BlocProvider<MotionAnalyzerCubit>(
        create: (_) => sl<MotionAnalyzerCubit>(),
        child: const UploadVideoScreen(),
      ),
    ),
    _fullScreenRoute(
      AppRoutes.analysisProcessing,
      BlocProvider<MotionAnalyzerCubit>(
        create: (_) => sl<MotionAnalyzerCubit>(),
        child: const AnalysisProcessingScreen(),
      ),
    ),
    _fullScreenRoute(
      AppRoutes.analysisResults,
      BlocProvider<MotionAnalyzerCubit>(
        create: (_) => sl<MotionAnalyzerCubit>(),
        child: const AnalysisResultsScreen(),
      ),
    ),
    _fullScreenRoute(AppRoutes.movementHistory, const MovementHistoryScreen()),
    _fullScreenRoute(AppRoutes.physio, const PhysioScreen()),
    _fullScreenRoute(
      AppRoutes.painAssessment,
      BlocProvider<AiPhysioCubit>(
        create: (_) => sl<AiPhysioCubit>(),
        child: const PainAssessmentScreen(),
      ),
    ),
    _fullScreenRoute(
      AppRoutes.recoveryPlan,
      BlocProvider<AiPhysioCubit>(
        create: (_) => sl<AiPhysioCubit>(),
        child: const RecoveryPlanScreen(),
      ),
    ),
    _fullScreenRoute(AppRoutes.mobilityHub, const MobilityHubScreen()),
    _fullScreenRoute(AppRoutes.consultationForm, const ConsultationFormScreen()),
    _fullScreenRoute(AppRoutes.digitalAthlete, const DigitalAthleteHubScreen()),
    _fullScreenRoute(AppRoutes.avatarViewer, const AvatarViewerScreen()),
    _fullScreenRoute(AppRoutes.predictions, const PredictionsScreen()),
    _fullScreenRoute(AppRoutes.transformationTimeline, const TransformationTimelineScreen()),

    GoRoute(
      path: AppRoutes.categoryBrowse,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        final category = state.uri.queryParameters['category'] ?? 'Supplements';
        return buildOctaTransitionPage(
          state: state,
          child: BlocProvider.value(
            value: sl<MarketplaceCubit>(),
            child: CategoryBrowseScreen(category: category),
          ),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.productDetail,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        final productId = state.uri.queryParameters['id'] ?? 'prod1';
        return buildOctaTransitionPage(
          state: state,
          child: BlocProvider.value(
            value: sl<MarketplaceCubit>(),
            child: ProductDetailScreen(productId: productId),
          ),
        );
      },
    ),
    _fullScreenRoute(
      AppRoutes.cart,
      BlocProvider<MarketplaceCubit>(
        create: (_) => sl<MarketplaceCubit>(),
        child: const CartScreen(),
      ),
    ),
    _fullScreenRoute(AppRoutes.checkoutAddress, const CheckoutAddressScreen()),
    _fullScreenRoute(AppRoutes.checkoutPayment, const CheckoutPaymentScreen()),
    _fullScreenRoute(AppRoutes.checkoutReview, const CheckoutReviewScreen()),
    _fullScreenRoute(AppRoutes.orderSuccess, const OrderSuccessScreen()),
    GoRoute(
      path: AppRoutes.orderTracking,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        final orderId = state.uri.queryParameters['id'];
        return buildOctaTransitionPage(
          state: state,
          child: OrderTrackingScreen(orderId: orderId),
        );
      },
    ),
    _fullScreenRoute(
      AppRoutes.wishlist,
      BlocProvider.value(
        value: sl<MarketplaceCubit>(),
        child: const WishlistScreen(),
      ),
    ),

    _fullScreenRoute(
      AppRoutes.community,
      BlocProvider<CommunityCubit>(
        create: (_) => sl<CommunityCubit>(),
        child: const CommunityFeedScreen(),
      ),
    ),
    _fullScreenRoute(
      AppRoutes.createPost,
      BlocProvider.value(
        value: sl<CommunityCubit>(),
        child: const CreatePostScreen(),
      ),
    ),
    _fullScreenRoute(
      AppRoutes.achievements,
      BlocProvider.value(
        value: sl<CommunityCubit>(),
        child: const AchievementsScreen(),
      ),
    ),
    _fullScreenRoute(
      AppRoutes.challenges,
      BlocProvider.value(
        value: sl<CommunityCubit>(),
        child: const ChallengesScreen(),
      ),
    ),
    _fullScreenRoute(
      AppRoutes.leaderboard,
      BlocProvider.value(
        value: sl<CommunityCubit>(),
        child: const LeaderboardScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.userProfile,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        final username = state.uri.queryParameters['user'];
        return buildOctaTransitionPage(
          state: state,
          child: UserProfileScreen(username: username),
        );
      },
    ),
    _fullScreenRoute(AppRoutes.sportsGroups, const SportsGroupsScreen()),
    _fullScreenRoute(AppRoutes.communityEvents, const CommunityEventsScreen()),
    _fullScreenRoute(AppRoutes.milestones, const MilestonesScreen()),

    _fullScreenRoute(AppRoutes.editProfile, const EditProfileScreen()),
    _fullScreenRoute(AppRoutes.settings, const SettingsScreen()),
    _fullScreenRoute(AppRoutes.membership, const MembershipScreen()),
    _fullScreenRoute(
      AppRoutes.subscriptionPaywall,
      const SubscriptionPaywallScreen(),
    ),
  ],
  errorBuilder: (context, state) => _RoutePlaceholder(
    title: 'Not Found',
    subtitle: state.uri.path,
    showBack: true,
  ),
);

GoRoute _shellRoute(String path, Widget child) {
  return GoRoute(
    path: path,
    pageBuilder: (context, state) => buildOctaTransitionPage(
      state: state,
      child: child,
    ),
  );
}

GoRoute _fullScreenRoute(String path, Widget child) {
  return GoRoute(
    path: path,
    parentNavigatorKey: _rootNavigatorKey,
    pageBuilder: (context, state) => buildOctaTransitionPage(
      state: state,
      child: child,
    ),
  );
}

class _OctaShell extends StatelessWidget {
  const _OctaShell({
    required this.location,
    required this.child,
  });

  final String location;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.bg : AppColors.lightBg,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const _ShellBackground(),
          child,
        ],
      ),
      bottomNavigationBar: OctaBottomNavBar(
        activeTab: OctaBottomNavBar.tabFromPath(location),
      ),
    );
  }
}

class _ShellBackground extends StatelessWidget {
  const _ShellBackground();

  @override
  Widget build(BuildContext context) {
    return const IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            left: -60,
            top: -40,
            child: _BlurredOrb(color: AppColors.blue, size: 240),
          ),
          Positioned(
            right: -40,
            top: 120,
            child: _BlurredOrb(color: AppColors.purple, size: 200, opacity: 0.25),
          ),
        ],
      ),
    );
  }
}

class _BlurredOrb extends StatelessWidget {
  const _BlurredOrb({
    required this.color,
    required this.size,
    this.opacity = 0.3,
  });

  final Color color;
  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color.withValues(alpha: opacity),
            color.withValues(alpha: 0),
          ],
          stops: const [0, 0.7],
        ),
      ),
    );
  }
}

class _RoutePlaceholder extends StatelessWidget {
  const _RoutePlaceholder({
    required this.title,
    this.subtitle,
    this.showBack = false,
  });

  final String title;
  final String? subtitle;
  final bool showBack;

  @override
  Widget build(BuildContext context) {
    return OctaScreen(
      showOrbs: true,
      safeArea: false,
      body: Column(
        children: [
          if (showBack)
            OctaTopBar(
              title: title,
              subtitle: subtitle,
              showBack: true,
            ),
          Expanded(child: _placeholderBody),
        ],
      ),
    );
  }

  Widget get _placeholderBody => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline_rounded,
                size: 48,
                color: AppColors.blue.withValues(alpha: 0.6),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 8),
                Text(
                  subtitle!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: AppColors.gray,
                  ),
                ),
              ],
            ],
          ),
        ),
      );
}
