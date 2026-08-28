import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:octafit/app.dart';
import 'package:octafit/core/di/injection.dart';
import 'package:octafit/core/storage/preferences_service.dart';
import 'package:octafit/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:octafit/features/settings/presentation/cubit/settings_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(     
    MultiBlocProvider(
      providers: [
        BlocProvider<SettingsCubit>(
          create: (_) => SettingsCubit(preferences: sl<PreferencesService>()),
        ),
        BlocProvider<AuthCubit>(
          create: (_) => sl<AuthCubit>(),
        ),
      ],
      child: const OctaFitApp(),
    ), 
  );
}


