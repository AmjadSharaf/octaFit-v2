import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:octafit/core/config/app_config.dart';
import 'package:octafit/core/network/api_client.dart';
import 'package:octafit/core/services/logger_service.dart';
import 'package:octafit/core/storage/preferences_service.dart';
import 'package:octafit/core/storage/secure_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Feature-layer imports (Clean Architecture)
import 'package:octafit/features/authentication/data/datasources/auth_local_data_source.dart';
import 'package:octafit/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:octafit/features/authentication/data/repositories/auth_repository_impl.dart' as feature_auth;
import 'package:octafit/features/authentication/domain/repositories/auth_repository.dart' as feature_auth_repo;
import 'package:octafit/features/authentication/domain/usecases/login_usecase.dart';
import 'package:octafit/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:octafit/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:octafit/features/authentication/presentation/cubit/assessment_cubit.dart';

import 'package:octafit/features/settings/presentation/cubit/settings_cubit.dart';

import 'package:octafit/features/ai_coach/domain/repositories/ai_coach_repository.dart' as feature_ai_coach_repo;
import 'package:octafit/features/ai_coach/domain/usecases/generate_workout_plan_usecase.dart';
import 'package:octafit/features/ai_coach/presentation/cubit/ai_coach_cubit.dart';

import 'package:octafit/features/ai_physio/domain/repositories/ai_physio_repository.dart' as feature_ai_physio_repo;
import 'package:octafit/features/ai_physio/presentation/cubit/ai_physio_cubit.dart';

import 'package:octafit/features/ai_motion_analyzer/domain/repositories/motion_analyzer_repository.dart' as feature_motion_repo;
import 'package:octafit/features/ai_motion_analyzer/presentation/cubit/motion_analyzer_cubit.dart';

import 'package:octafit/features/ai_digital_athlete/domain/repositories/digital_athlete_repository.dart' as feature_da_repo;
import 'package:octafit/features/ai_digital_athlete/presentation/cubit/digital_athlete_cubit.dart';

import 'package:octafit/features/community/domain/repositories/community_repository.dart' as feature_community_repo;
import 'package:octafit/features/community/presentation/cubit/community_cubit.dart';

import 'package:octafit/features/marketplace/domain/repositories/marketplace_repository.dart' as feature_marketplace_repo;
import 'package:octafit/features/marketplace/presentation/cubit/marketplace_cubit.dart';

import 'package:octafit/features/home/domain/repositories/home_repository.dart' as feature_home_repo;
import 'package:octafit/features/home/presentation/cubit/home_cubit.dart';
import 'package:octafit/features/training/domain/repositories/training_repository.dart' as feature_training_repo;
import 'package:octafit/features/training/presentation/cubit/training_cubit.dart';
import 'package:octafit/features/training/presentation/cubit/workout_session_cubit.dart';
import 'package:octafit/features/notifications/domain/repositories/notification_repository.dart' as feature_notif_repo;
import 'package:octafit/features/notifications/presentation/cubit/notifications_cubit.dart';

// AI Service
import 'package:octafit/core/services/ai/ai_provider.dart';
import 'package:octafit/core/services/ai/ai_service.dart';
import 'package:octafit/core/services/ai/providers/openai_provider.dart';
import 'package:octafit/core/services/ai/providers/claude_provider.dart';
import 'package:octafit/core/services/ai/providers/gemini_provider.dart';

final sl = GetIt.instance;

final getIt = sl;

Future<void> initializeDependencies() async {
  if (sl.isRegistered<LoggerService>()) return;

await _registerCore();
await _registerStorage();   // 👈 MOVE UP (هذا التعديل الوحيد)
await _registerNetwork();
await _registerAi();
await _registerFeatures();
}

Future<void> _registerCore() async {
  sl.registerLazySingleton<LoggerService>(
    () => LoggerService(level: AppConfig.logLevel),
  );

  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<PreferencesService>(
    () => PreferencesService(prefs),
  );
}

Future<void> _registerNetwork() async {
  final secureStorage = sl<SecureStorageService>();
  final loggerService = sl<LoggerService>();

  sl.registerLazySingleton<Dio>(
    () => Dio(),
  );

  sl.registerLazySingleton<ApiClient>(
    () => ApiClient(
      secureStorage: secureStorage,
      loggerService: loggerService,
    ),
  );
}

Future<void> _registerStorage() async {
  const flutterSecureStorage = FlutterSecureStorage();
  sl.registerLazySingleton<SecureStorageService>(
    () => SecureStorageService(flutterSecureStorage),
  );
}

Future<void> _registerAi() async {
  final apiClient = sl<ApiClient>();
  final logger = sl<LoggerService>();

  sl.registerLazySingleton<OpenAiProvider>(
    () => OpenAiProvider(apiClient, AppConfig.openAiApiKey),
  );
  sl.registerLazySingleton<ClaudeProvider>(
    () => ClaudeProvider(apiClient, AppConfig.claudeApiKey),
  );
  sl.registerLazySingleton<GeminiProvider>(
    () => GeminiProvider(apiClient, AppConfig.geminiApiKey),
  );

  sl.registerLazySingleton<AiService>(
    () => AiService(
      providers: {
        AiProviderType.openAI: sl<OpenAiProvider>(),
        AiProviderType.claude: sl<ClaudeProvider>(),
        AiProviderType.gemini: sl<GeminiProvider>(),
      },
      logger: logger,
    ),
  );
}

Future<void> _registerFeatures() async {
  final logger = sl<LoggerService>();

  // ─── Authentication (fully implemented Clean Architecture) ───
  _registerAuthModule(logger);

  // ─── Settings ───
  _registerSettingsModule();

  // ─── Home ───
  _registerHomeModule();

  // ─── Training ───
  _registerTrainingModule();

  // ─── Community ───
  _registerCommunityModule(logger);

  // ─── Marketplace ───
  _registerMarketplaceModule(logger);

  // ─── Notifications ───
  _registerNotificationsModule();

  // ─── AI Coach ───
  _registerAiCoachModule(logger);

  // ─── AI Physio ───
  _registerAiPhysioModule(logger);

  // ─── AI Motion Analyzer ───
  _registerAiMotionAnalyzerModule(logger);

  // ─── AI Digital Athlete ───
  _registerAiDigitalAthleteModule(logger);

  logger.info('Feature-layer Clean Architecture registrations complete');
}

void _registerAuthModule(LoggerService logger) {
  final apiClient = sl<ApiClient>();
  final secureStorage = sl<SecureStorageService>();
  final preferences = sl<PreferencesService>();

  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSource(secureStorage, preferences),
  );
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(apiClient),
  );

  sl.registerLazySingleton<feature_auth_repo.AuthRepository>(
    () => feature_auth.AuthRepositoryImpl(
      sl<AuthRemoteDataSource>(),
      sl<AuthLocalDataSource>(),
      logger,
    ),
  );

  final authRepo = sl<feature_auth_repo.AuthRepository>();
  sl.registerFactory<LoginUseCase>(() => LoginUseCase(authRepo));
  sl.registerFactory<RegisterUseCase>(() => RegisterUseCase(authRepo));
  sl.registerFactory<ForgotPasswordUseCase>(() => ForgotPasswordUseCase(authRepo));
  sl.registerFactory<ResetPasswordUseCase>(() => ResetPasswordUseCase(authRepo));
  sl.registerFactory<VerifyEmailUseCase>(() => VerifyEmailUseCase(authRepo));
  sl.registerFactory<SocialLoginUseCase>(() => SocialLoginUseCase(authRepo));
  sl.registerFactory<LogoutUseCase>(() => LogoutUseCase(authRepo));

  sl.registerFactory<AuthCubit>(
    () => AuthCubit(
      loginUseCase: sl<LoginUseCase>(),
      registerUseCase: sl<RegisterUseCase>(),
      forgotPasswordUseCase: sl<ForgotPasswordUseCase>(),
      resetPasswordUseCase: sl<ResetPasswordUseCase>(),
      verifyEmailUseCase: sl<VerifyEmailUseCase>(),
      logoutUseCase: sl<LogoutUseCase>(),
    ),
  );

  sl.registerLazySingleton<AssessmentCubit>(
    () => AssessmentCubit(),
  );
}

void _registerSettingsModule() {
  sl.registerFactory<SettingsCubit>(
    () => SettingsCubit(preferences: sl<PreferencesService>()),
  );
}

void _registerHomeModule() {
  sl.registerFactory<feature_home_repo.HomeRepository>(
    () => feature_home_repo.MockHomeRepository(),
  );
  sl.registerFactory<HomeCubit>(
    () => HomeCubit(repository: sl<feature_home_repo.HomeRepository>()),
  );
}

void _registerTrainingModule() {
  sl.registerFactory<feature_training_repo.TrainingRepository>(
    () => feature_training_repo.MockTrainingRepository(),
  );
  sl.registerFactory<TrainingCubit>(
    () => TrainingCubit(repository: sl<feature_training_repo.TrainingRepository>()),
  );
  sl.registerLazySingleton<WorkoutSessionCubit>(
    () => WorkoutSessionCubit(),
  );
}

void _registerCommunityModule(LoggerService logger) {
  sl.registerFactory<feature_community_repo.CommunityRepository>(
    () => feature_community_repo.MockCommunityRepository(),
  );
  sl.registerFactory<CommunityCubit>(
    () => CommunityCubit(repository: sl<feature_community_repo.CommunityRepository>()),
  );
}

void _registerMarketplaceModule(LoggerService logger) {
  sl.registerFactory<feature_marketplace_repo.MarketplaceRepository>(
    () => feature_marketplace_repo.MockMarketplaceRepository(),
  );
  sl.registerFactory<MarketplaceCubit>(
    () => MarketplaceCubit(repository: sl<feature_marketplace_repo.MarketplaceRepository>()),
  );
}

void _registerNotificationsModule() {
  sl.registerFactory<feature_notif_repo.NotificationRepository>(
    () => feature_notif_repo.MockNotificationRepository(),
  );
  sl.registerFactory<NotificationsCubit>(
    () => NotificationsCubit(repository: sl<feature_notif_repo.NotificationRepository>()),
  );
}

void _registerAiCoachModule(LoggerService logger) {
  sl.registerFactory<feature_ai_coach_repo.AiCoachRepository>(
    () => feature_ai_coach_repo.MockAiCoachRepository(),
  );
  final aiCoachRepo = sl<feature_ai_coach_repo.AiCoachRepository>();

  sl.registerFactory<GenerateWorkoutPlanUseCase>(
    () => GenerateWorkoutPlanUseCase(aiCoachRepo),
  );
  sl.registerFactory<GenerateNutritionPlanUseCase>(
    () => GenerateNutritionPlanUseCase(aiCoachRepo),
  );
  sl.registerFactory<ModifyPlanUseCase>(
    () => ModifyPlanUseCase(aiCoachRepo),
  );
  sl.registerFactory<AnswerQuestionUseCase>(
    () => AnswerQuestionUseCase(aiCoachRepo),
  );
  sl.registerFactory<AnalyzeMealUseCase>(
    () => AnalyzeMealUseCase(aiCoachRepo),
  );
  sl.registerFactory<EvaluateMealUseCase>(
    () => EvaluateMealUseCase(aiCoachRepo),
  );
  sl.registerFactory<SuggestAlternativesUseCase>(
    () => SuggestAlternativesUseCase(aiCoachRepo),
  );

  sl.registerFactory<AiCoachCubit>(
    () => AiCoachCubit(
      generateWorkoutPlan: sl<GenerateWorkoutPlanUseCase>(),
      generateNutritionPlan: sl<GenerateNutritionPlanUseCase>(),
      answerQuestion: sl<AnswerQuestionUseCase>(),
      analyzeMeal: sl<AnalyzeMealUseCase>(),
      evaluateMeal: sl<EvaluateMealUseCase>(),
      suggestAlternatives: sl<SuggestAlternativesUseCase>(),
    ),
  );
}

void _registerAiPhysioModule(LoggerService logger) {
  sl.registerFactory<feature_ai_physio_repo.AiPhysioRepository>(
    () => feature_ai_physio_repo.MockAiPhysioRepository(),
  );
  sl.registerLazySingleton<AiPhysioCubit>(
    () => AiPhysioCubit(repository: sl<feature_ai_physio_repo.AiPhysioRepository>()),
  );
}

void _registerAiMotionAnalyzerModule(LoggerService logger) {
  sl.registerFactory<feature_motion_repo.MotionAnalyzerRepository>(
    () => feature_motion_repo.MockMotionAnalyzerRepository(),
  );
  sl.registerLazySingleton<MotionAnalyzerCubit>(
    () => MotionAnalyzerCubit(repository: sl<feature_motion_repo.MotionAnalyzerRepository>()),
  );
}

void _registerAiDigitalAthleteModule(LoggerService logger) {
  sl.registerFactory<feature_da_repo.DigitalAthleteRepository>(
    () => feature_da_repo.MockDigitalAthleteRepository(),
  );
  sl.registerFactory<DigitalAthleteCubit>(
    () => DigitalAthleteCubit(repository: sl<feature_da_repo.DigitalAthleteRepository>()),
  );
}


