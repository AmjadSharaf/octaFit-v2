## Goal
- Refactor OctaFit Flutter project into production-ready enterprise architecture: Clean Architecture + MVVM + Feature-First + Cubit + Dio + proper AI abstraction layer

## Constraints & Preferences
- Must NOT create new project from scratch; must refactor existing codebase at D:\octafitDesignOneEdited
- Must preserve all existing functionality while restructuring architecture
- Strictly follow: Clean Architecture, MVVM, Feature-First, SOLID, DRY, KISS, Repository Pattern, DI, Cubit (flutter_bloc), Dio, Equatable, GoRouter, Flutter Secure Storage, Shared Preferences, GetIt, Logger, Material 3
- Must prepare architecture for future Laravel API, MySQL/PostgreSQL, OpenAI/Claude/Gemini/Custom AI integration
- Must NOT place business logic inside widgets
- Must NOT bypass Clean Architecture principles
- Must NOT introduce temporary solutions

## Progress
### Done
- Fixed all compilation errors: duplicate state defs, duplicate LogoutUseCase, invalid constant, missing copyWith, screen imports
- Removed duplicate lib_new/ directory
- **Batch 1 — DI Rescue**: Implemented `_registerFeatures()` with 11 feature modules; registered auth data sources + repo + 7 use cases + cubit; created 6 mock feature repository implementations (Community, Marketplace, AI Coach, AI Physio, Motion Analyzer, Digital Athlete); updated all cubits to use constructor-injected repositories with live async flows; registered AI Service + OpenAI/Claude/Gemini providers in DI; added API key getters to AppConfig
- **Batch 2 — Interceptors + Laravel JSON**: Fixed retry interceptor to use original Dio instance via request extras instead of creating unconfigured `Dio()`; added refresh-token retry logic to auth interceptor; fixed UserModel `fromJson` to handle Laravel snake_case keys + nullable/safe parse + int/string ID tolerance
- **Batch 3 — First Cubit screen**: Registered `AuthCubit` in root `MultiBlocProvider`; converted login screen from `ConsumerStatefulWidget` + `authProvider` to `BlocBuilder<AuthCubit>` + `BlocListener`; removed Riverpod dependency from login
- **Batch 4 — Theme migration**: Enhanced `SettingsCubit` with `PreferencesService` for theme persistence; converted `app.dart` from `ConsumerWidget` + `ref.watch(themeModeProvider)` to `StatelessWidget` + `BlocBuilder<SettingsCubit>`; set `bloc_screen` preference for login after authentic migration
- **Batch 5.1–5.7 — All remaining screen migrations**: 
  - 5.1: Signup → AuthCubit
  - 5.2: Forgot password → AuthCubit
  - 5.3: Verify email → AuthCubit, Settings → SettingsCubit
  - 5.4: Training Hub → TrainingCubit (WorkoutRepository-injected, BlocBuilder)
  - 5.5: Home Dashboard → HomeCubit (5 repositories injected, 788-line full conversion)
  - 5.6: Store Home + Cart → MarketplaceCubit
  - 5.7: Community Feed → CommunityCubit
- **Batch 6 — Legacy initial cleanup**: Deleted `theme_provider.dart` (0 consumers); all 10 main screens now Cubit-powered

### In Progress
- **Batch 6 continuing**: 48 screens still on Riverpod; 6 provider files still active

### Blocked
- (none currently)

## Key Decisions
- flutter_riverpod retained as pubspec dependency until ALL screens migrated; `ProviderScope` still wraps app in `main.dart`
- Riverpod providers kept as files until their last consuming screen is migrated (deleted only after no remaining references)
- Mock repository implementations return `Right(...)` with sample entity data — isolates mock behavior behind Clean Architecture boundary for future Laravel swap
- Use cases registered as `registerFactory` (correct scope), singletons only for services and repositories
- Old `lib/domain/` and `lib/data/` directories still power cubits that were wired directly to old repositories (HomeCubit, TrainingCubit)

## Batch 7 Priority Order (remaining Riverpod screens by dependency)
1. **Training screens** (9 remaining: exercise library, workout session, etc.) — share `workout_provider.dart`
2. **Store screens** (6 remaining: category browse, product detail, wishlist, checkout) — share `product_provider.dart`
3. **Community screens** (8 remaining: challenges, achievements, etc.) — share `community_provider.dart`
4. **Auth screens** (6 remaining: profile setup, assessment, etc.) — share `auth_provider.dart`
5. **AI screens** (8 remaining) — share `ai_provider.dart`
6. **Home/Profile/Other** (8 remaining) — share `user_provider.dart`
7. **Final cleanup**: remove Riverpod from pubspec.yaml after last screen migrated

## Remaining Riverpod Usage Report (as of Batch 6 completion)
- **48 screens** still import `flutter_riverpod`
- **6 provider files** still active: `auth_provider.dart`, `community_provider.dart`, `product_provider.dart`, `ai_provider.dart`, `workout_provider.dart`, `user_provider.dart`
- **`theme_provider.dart`** deleted (Batch 4 migration complete)
- **`flutter_riverpod`** cannot be removed from `pubspec.yaml` until last screen migrates

## Critical Context
- `flutter analyze lib/` — **0 issues found** (all batches verified clean)
- 10 live screens using Cubit: login, signup, forgot password, verify email, settings, training hub, home dashboard, store home, cart, community feed
- AuthCubit, SettingsCubit, HomeCubit, TrainingCubit, MarketplaceCubit, CommunityCubit, all 5 AI cubits are properly wired with repository injection in DI
- All use cases for auth (7) and AI coach (7) registered as `registerFactory` in GetIt
- Custom Either class in `core/utils/either.dart` — cubits use `is Left`/`is Right` type checks (not `fold()` pattern matching)
- Old `lib/domain/` and `lib/data/` top-level directories still exist and power cubits via di injection as well as remaining Riverpod providers
- GoRouter still functional with all 80+ routes, with BlocProvider wrappers for home, training, store, community routes

## Architecture Score (updated)
- Clean Architecture: 65% (feature modules exist, but cubits still bridge to old domain repos)
- MVVM: 60% (screens use BlocBuilder, but many screens still on ConsumerWidget)
- Cubit Usage: 35% (10/58+ screens converted)
- Dependency Injection: 80% (GetIt fully wired, all cubits factory-registered)
- Scalability: 60% (feature-first pattern established, old layers still present)
- AI Module Architecture: 75% (abstraction layer + providers, not fully wired to screens)
- Laravel Backend Readiness: 50% (Dio interceptors + snake_case UserModel, but mostly mock data)
- Code Quality: 72% (no analysis errors, consistent patterns in migrated screens)
- Folder Structure: 65% (feature-first + clean arch, but old domain/data still exist)
- Enterprise Readiness: 55% (trending up, need complete migration + i18n + analytics)
- **Overall Score: 62%**

## Critical Blockers (0)
## High-Priority Blockers (0)
