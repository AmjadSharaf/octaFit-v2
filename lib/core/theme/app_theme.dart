import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';

abstract final class AppTheme {
  static ThemeData get dark => _buildTheme(isDark: true);
  static ThemeData get light => _buildTheme(isDark: false);

  static ThemeData _buildTheme({required bool isDark}) {
    final bg = isDark ? AppColors.bg : AppColors.lightBg;
    final surface = isDark ? AppColors.bg2 : AppColors.lightBg2;
    final textPrimary = isDark ? AppColors.white : AppColors.lightText;
    final textSecondary = isDark ? AppColors.gray : AppColors.lightGray;
    final border = isDark ? AppColors.glassBorder : AppColors.lightBorder;

    final spaceGrotesk = GoogleFonts.spaceGroteskTextTheme();
    final inter = GoogleFonts.interTextTheme();

    final base = isDark ? ThemeData.dark() : ThemeData.light();

    return base.copyWith(
      brightness: isDark ? Brightness.dark : Brightness.light,
      scaffoldBackgroundColor: bg,
      canvasColor: bg,
      primaryColor: AppColors.blue,
      colorScheme: ColorScheme(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primary: AppColors.blue,
        onPrimary: AppColors.white,
        secondary: AppColors.purple,
        onSecondary: AppColors.white,
        tertiary: AppColors.cyan,
        onTertiary: AppColors.bg,
        error: AppColors.red,
        onError: AppColors.white,
        surface: surface,
        onSurface: textPrimary,
        onSurfaceVariant: textSecondary,
      ),
      textTheme: inter.copyWith(
        displayLarge: spaceGrotesk.displayLarge?.copyWith(
          color: textPrimary,
          fontWeight: FontWeight.w700,
        ),
        displayMedium: spaceGrotesk.displayMedium?.copyWith(
          color: textPrimary,
          fontWeight: FontWeight.w700,
        ),
        displaySmall: spaceGrotesk.displaySmall?.copyWith(
          color: textPrimary,
          fontWeight: FontWeight.w700,
        ),
        headlineLarge: spaceGrotesk.headlineLarge?.copyWith(
          color: textPrimary,
          fontWeight: FontWeight.w700,
        ),
        headlineMedium: spaceGrotesk.headlineMedium?.copyWith(
          color: textPrimary,
          fontWeight: FontWeight.w700,
        ),
        headlineSmall: spaceGrotesk.headlineSmall?.copyWith(
          color: textPrimary,
          fontWeight: FontWeight.w700,
        ),
        titleLarge: spaceGrotesk.titleLarge?.copyWith(
          color: textPrimary,
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
        titleMedium: spaceGrotesk.titleMedium?.copyWith(
          color: textPrimary,
          fontWeight: FontWeight.w600,
        ),
        titleSmall: spaceGrotesk.titleSmall?.copyWith(
          color: textPrimary,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: inter.bodyLarge?.copyWith(color: textPrimary),
        bodyMedium: inter.bodyMedium?.copyWith(color: textPrimary),
        bodySmall: inter.bodySmall?.copyWith(color: textSecondary),
        labelLarge: inter.labelLarge?.copyWith(
          color: textPrimary,
          fontWeight: FontWeight.w600,
        ),
        labelMedium: inter.labelMedium?.copyWith(color: textSecondary),
        labelSmall: inter.labelSmall?.copyWith(
          color: textSecondary,
          fontSize: 11,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: textPrimary),
        titleTextStyle: GoogleFonts.spaceGrotesk(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),
      ),
      dividerTheme: DividerThemeData(color: border, thickness: 1),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? AppColors.inputFill : AppColors.lightInputFill,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.blue, width: 1.5),
        ),
        hintStyle: GoogleFonts.inter(
          color: textSecondary,
          fontSize: 15,
        ),
        labelStyle: GoogleFonts.inter(
          color: textSecondary,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: isDark
            ? AppColors.bg.withValues(alpha: 0.95)
            : AppColors.lightBg2,
        selectedItemColor: AppColors.blue,
        unselectedItemColor: AppColors.dimGray,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.w400,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: isDark ? AppColors.chipInactive : AppColors.lightInputFill,
        selectedColor: AppColors.blue,
        labelStyle: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: isDark ? AppColors.bg3 : AppColors.lightBg2,
        contentTextStyle: GoogleFonts.inter(color: textPrimary),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: border),
        ),
      ),
      iconTheme: IconThemeData(color: textPrimary),
      splashFactory: NoSplash.splashFactory,
      highlightColor: AppColors.blue.withValues(alpha: 0.08),
    );
  }
}
