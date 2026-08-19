import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:octafitv2/app.dart';
import 'package:octafitv2/core/storage/preferences_service.dart';
import 'package:octafitv2/features/auth/data/Repository%20Implementation/auth_repository_impl.dart';
import 'package:octafitv2/features/auth/persentation/manegar/auth_cubit.dart';
import 'package:octafitv2/features/home/domain/repositories/home_repository.dart'; // ← أضف
import 'package:octafitv2/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final preferencesService = PreferencesService(prefs);

  final authRepository = AuthRepositoryImpl(prefs);
  final homeRepository = MockHomeRepository(); // ← أنشئه هنا

  runApp(
    MultiRepositoryProvider(
      // ← أضف هذا
      providers: [
        RepositoryProvider<HomeRepository>(create: (_) => homeRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SettingsCubit(
              preferencesService: preferencesService,
              preferences: preferencesService,
            ),
          ),
          BlocProvider(create: (context) => AuthCubit(authRepository)),
        ],
        child: const OctaApp(),
      ),
    ),
  );
}
