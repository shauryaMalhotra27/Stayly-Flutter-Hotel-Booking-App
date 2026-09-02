import 'package:flutter/material.dart';

/// Centralized color tokens from Figma.
class AppColors {
  AppColors._();

  // Primary brand colors
  static const Color primary = Color(0xFF0D9BFF);
  static const Color primaryVariant = Color(0xFF179FFF);

  // Secondary/Accent colors
  static const Color accentOrange = Color(0xFFFFAB26);
  static const Color accentGreen = Color(0xFF6FB114);
  static const Color pageDotActive = Color(0xFFFF8000);

  /// Cancel Date text fill (Figma #FF8000).
  static const Color cancelDate = Color(0xFFFF8000);

  /// Cancel Date underline — lighter orange than the text fill.
  static const Color cancelDateUnderline = Color(0xFFFFC266);

  // Background and Surface colors
  static const Color backgroundDark = Color(0xFF0C0E0D);
  static const Color surfaceDark = Color(0xFF1C1C1E);
  static const Color surfaceBorder = Color(0xFF2C2C2C);

  /// Inactive nav pill fill (Figma #373737).
  static const Color navInactive = Color(0xFF373737);

  /// Menu button frosted fill — white @ ~16% (reads as soft glass on dark).
  static const Color menuButton = Color(0x29FFFFFF);

  /// Menu button stroke — off-white @ ~40%.
  static const Color menuButtonBorder = Color(0x66FFFFFF);

  // Grey palette
  static const Color greyText = Color(0xFF888F9B);
  static const Color greyDark = Color(0xFF363637);

  // Text colors
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xADFFFFFF); // ~68% white
  static const Color textMuted = Color(0x99FFFFFF); // ~60% white
  static const Color textSoft = Color(0xE6FFFFFF); // ~90% white

  // Skeleton / shimmer
  static const Color shimmerBase = Color(0xFF2A2A2C);
  static const Color shimmerHighlight = Color(0xFF3A3A3C);

  // Card image border
  static const Color cardStroke = Color(0x3074757F);
}
