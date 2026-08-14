import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:octafitv2/core/Utils/responsive.dart';
import 'package:octafitv2/core/routing/app_router.dart';
import 'package:octafitv2/core/theme/app_theme.dart';
import 'package:octafitv2/features/settings/presentation/cubit/settings_cubit.dart';

class OctaApp extends StatelessWidget {
  const OctaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'OctaFit',
          routerConfig: appRouter,
          themeMode: state.themeMode,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,

          builder: (context, child) =>
              OctaLayout.constrain(child ?? SizedBox.shrink()),
        );
      },
    );
  }
}
