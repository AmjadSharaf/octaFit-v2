import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:octafit/core/routing/app_router.dart';
import 'package:octafit/core/theme/app_theme.dart';
import 'package:octafit/core/utils/responsive.dart';
import 'package:octafit/features/settings/presentation/cubit/settings_cubit.dart';

class OctaFitApp extends StatelessWidget {
  const OctaFitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return MaterialApp.router(
          title: 'OctaFit',
          debugShowCheckedModeBanner: false,
          themeMode: state.themeMode,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          routerConfig: appRouter,
          supportedLocales: const [
            Locale('en'),
            Locale('ar'),
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          builder: (context, child) {
            return OctaLayout.constrain(child ?? const SizedBox.shrink());
          },
        );
      },
    );
  }
}
