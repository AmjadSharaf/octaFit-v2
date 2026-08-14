import 'package:flutter/material.dart';

/// OctaFit brand palette — mirrors the React OctaUI design tokens.
abstract final class AppColors {
  // ─── Core backgrounds ─────────────────────────────────────────────────────
  static const Color bg = Color(0xFF0A0A0F);
  static const Color bg2 = Color(0xFF0D0D1A);
  static const Color bg3 = Color(0xFF111128);
  static const Color scaffoldDark = Color(0xFF050508);

  // ─── Brand accents ──────────────────────────────────────────────────────────
  static const Color blue = Color(0xFF0080FF);
  static const Color purple = Color(0xFF7B2FFF);
  static const Color cyan = Color(0xFF00D4FF);
  static const Color green = Color(0xFF00FF88);
  static const Color orange = Color(0xFFFF6B35);
  static const Color red = Color(0xFFFF3B5C);

  // ─── Text ─────────────────────────────────────────────────────────────────
  static const Color white = Color(0xFFF0F0FF);
  static const Color gray = Color(0x80F0F0FF);
  static const Color dimGray = Color(0x40F0F0FF);

  // ─── Glass surfaces ───────────────────────────────────────────────────────
  static const Color glass = Color(0x0DFFFFFF);
  static const Color glassBorder = Color(0x1AFFFFFF);
  static const Color glassBlue = Color(0x1F0080FF);
  static const Color glassBlueBorder = Color(0x400080FF);
  static const Color glassPurple = Color(0x1F7B2FFF);
  static const Color glassPurpleBorder = Color(0x407B2FFF);
  static const Color inputFill = Color(0x12FFFFFF);
  static const Color chipInactive = Color(0x14FFFFFF);

  // ─── Light mode ───────────────────────────────────────────────────────────
  static const Color lightBg = Color(0xFFF5F5FA);
  static const Color lightBg2 = Color(0xFFFFFFFF);
  static const Color lightText = Color(0xFF0A0A0F);
  static const Color lightGray = Color(0xFF717182);
  static const Color lightBorder = Color(0x1A000000);
  static const Color lightGlass = Color(0xCCFFFFFF);
  static const Color lightInputFill = Color(0xFFF3F3F5);

  // ─── Gradients ────────────────────────────────────────────────────────────
  static const LinearGradient gradBlue = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [blue, cyan],
  );

  static const LinearGradient gradPurple = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [purple, blue],
  );

  static const LinearGradient gradBoth = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [blue, purple],
  );

  static const LinearGradient gradDark = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF0D0D20), bg],
  );

  static const LinearGradient gradGreenCyan = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [green, cyan],
  );

  // ─── Glow shadows ─────────────────────────────────────────────────────────
  static List<BoxShadow> blueGlow({double blur = 20, double spread = 0}) => [
        BoxShadow(
          color: blue.withValues(alpha: 0.15),
          blurRadius: blur,
          spreadRadius: spread,
        ),
      ];

  static List<BoxShadow> purpleGlow({double blur = 20, double spread = 0}) => [
        BoxShadow(
          color: purple.withValues(alpha: 0.15),
          blurRadius: blur,
          spreadRadius: spread,
        ),
      ];

  static List<BoxShadow> buttonBlueShadow = [
    BoxShadow(
      color: blue.withValues(alpha: 0.3),
      blurRadius: 20,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> buttonPurpleShadow = [
    BoxShadow(
      color: purple.withValues(alpha: 0.3),
      blurRadius: 20,
      offset: const Offset(0, 4),
    ),
  ];

  // ─── Badge backgrounds ────────────────────────────────────────────────────
  static Color badgeBackground(BadgeColor color) => switch (color) {
        BadgeColor.blue => blue.withValues(alpha: 0.2),
        BadgeColor.purple => purple.withValues(alpha: 0.2),
        BadgeColor.green => green.withValues(alpha: 0.2),
        BadgeColor.orange => orange.withValues(alpha: 0.2),
        BadgeColor.red => red.withValues(alpha: 0.2),
      };

  static Color badgeForeground(BadgeColor color) => switch (color) {
        BadgeColor.blue => blue,
        BadgeColor.purple => purple,
        BadgeColor.green => green,
        BadgeColor.orange => orange,
        BadgeColor.red => red,
      };
}

enum BadgeColor { blue, purple, green, orange, red }

enum GlassGlow { none, blue, purple }

enum PrimaryButtonVariant { blue, purple, gradient, glass }
