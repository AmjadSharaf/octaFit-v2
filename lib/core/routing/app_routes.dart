abstract final class AppRoutes {
  // ─── Auth & Onboarding ─────────────────────────────────────────────────────
  static const splash = '/splash';
  static const welcome = '/welcome';
  static const onboarding1 = '/onboarding/1';
  static const onboarding2 = '/onboarding/2';
  static const onboarding3 = '/onboarding/3';
  static const onboarding4 = '/onboarding/4';
  static const onboarding5 = '/onboarding/5';
  static const signup = '/signup';
  static const verifyEmail = '/verify-email';
  static const createPassword = '/create-password';
  static const login = '/login';
  static const forgotPassword = '/forgot-password';
  static const profileSetup = '/profile-setup';
  static const assessment1 = '/assessment/1';
  static const assessment2 = '/assessment/2';
  static const assessment3 = '/assessment/3';
  static const assessment4 = '/assessment/4';
  static const assessment5 = '/assessment/5';
  static const assessment6 = '/assessment/6';
  static const assessment7 = '/assessment/7';
  static const assessment8 = '/assessment/8';
  static const assessmentSummary = '/assessment-summary';
  static const aiBlueprint = '/ai-blueprint';

  // ─── Home ──────────────────────────────────────────────────────────────────
  static const home = '/home';
  static const search = '/search';
  static const notifications = '/notifications';

  // ─── Training ──────────────────────────────────────────────────────────────
  static const training = '/training';
  static const programDetail = '/program-detail';
  static const workoutSession = '/workout-session';
  static const workoutComplete = '/workout-complete';
  static const exerciseLibrary = '/exercise-library';
  static const exerciseDetail = '/exercise-detail';
  static const logWorkout = '/log-workout';
  static const mmaHub = '/mma-hub';
  static const fighterProfile = '/fighter-profile';
  static const homeWorkout = '/home-workout';
  static const challengeDetail = '/challenge-detail';

  // ─── AI Hub ────────────────────────────────────────────────────────────────
  static const aiHub = '/ai-hub';
  static const aiCoach = '/ai-coach';
  static const aiChat = '/ai-chat';
  static const personalizedPlan = '/personalized-plan';
  static const nutrition = '/nutrition';
  static const habitTracker = '/habit-tracker';

  // ─── Motion Analyzer ───────────────────────────────────────────────────────
  static const motionAnalyzer = '/motion-analyzer';
  static const uploadVideo = '/upload-video';
  static const analysisProcessing = '/analysis-processing';
  static const analysisResults = '/analysis-results';
  static const movementHistory = '/movement-history';

  // ─── AI Physio ─────────────────────────────────────────────────────────────
  static const physio = '/physio';
  static const painAssessment = '/pain-assessment';
  static const recoveryPlan = '/recovery-plan';
  static const mobilityHub = '/mobility-hub';
  static const consultationForm = '/consultation-form';

  // ─── Digital Athlete ───────────────────────────────────────────────────────
  static const digitalAthlete = '/digital-athlete';
  static const avatarViewer = '/avatar-viewer';
  static const predictions = '/predictions';
  static const transformationTimeline = '/transformation-timeline';

  // ─── Store ─────────────────────────────────────────────────────────────────
  static const store = '/store';
  static const categoryBrowse = '/category-browse';
  static const productDetail = '/product-detail';
  static const cart = '/cart';
  static const checkoutAddress = '/checkout-address';
  static const checkoutPayment = '/checkout-payment';
  static const checkoutReview = '/checkout-review';
  static const orderSuccess = '/order-success';
  static const orderTracking = '/order-tracking';
  static const wishlist = '/wishlist';

  // ─── Community & Gamification ────────────────────────────────────────────
  static const community = '/community';
  static const createPost = '/create-post';
  static const userProfile = '/user-profile';
  static const sportsGroups = '/sports-groups';
  static const communityEvents = '/community-events';
  static const achievements = '/achievements';
  static const challenges = '/challenges';
  static const leaderboard = '/leaderboard';
  static const milestones = '/milestones';

  // ─── Profile & Settings ────────────────────────────────────────────────────
  static const profile = '/profile';
  static const editProfile = '/edit-profile';
  static const settings = '/settings';
  static const membership = '/membership';
  static const subscriptionPaywall = '/subscription-paywall';

  static int assessmentStepFromPath(String path) {
    if (path == assessment2) return 2;
    if (path == assessment3) return 3;
    if (path == assessment4) return 4;
    if (path == assessment5) return 5;
    if (path == assessment6) return 6;
    if (path == assessment7) return 7;
    if (path == assessment8) return 8;
    return 1;
  }

  static String assessmentPathForStep(int step) => '/assessment/$step';
}
