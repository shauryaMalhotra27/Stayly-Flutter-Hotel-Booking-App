import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_sizes.dart';

/// Typography tokens. Nohemi matches Figma wireframes.
class AppTypography {
  AppTypography._();

  static const String fontFamily = 'Nohemi';

  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;

  static const TextTheme textTheme = TextTheme(
    displayLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: 35.0,
      fontWeight: bold,
    ),
    displayMedium: TextStyle(
      fontFamily: fontFamily,
      fontSize: 22.0,
      fontWeight: bold,
    ),
    displaySmall: TextStyle(
      fontFamily: fontFamily,
      fontSize: 20.0,
      fontWeight: semiBold,
    ),
    headlineLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: 18.0,
      fontWeight: semiBold,
    ),
    headlineMedium: TextStyle(
      fontFamily: fontFamily,
      fontSize: 17.0,
      fontWeight: semiBold,
    ),
    headlineSmall: TextStyle(
      fontFamily: fontFamily,
      fontSize: 16.0,
      fontWeight: medium,
    ),
    titleLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: 16.0,
      fontWeight: semiBold,
    ),
    titleMedium: TextStyle(
      fontFamily: fontFamily,
      fontSize: 15.0,
      fontWeight: medium,
    ),
    titleSmall: TextStyle(
      fontFamily: fontFamily,
      fontSize: 14.0,
      fontWeight: medium,
    ),
    bodyLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: 16.0,
      fontWeight: regular,
    ),
    bodyMedium: TextStyle(
      fontFamily: fontFamily,
      fontSize: 14.0,
      fontWeight: regular,
    ),
    bodySmall: TextStyle(
      fontFamily: fontFamily,
      fontSize: 13.0,
      fontWeight: regular,
    ),
    labelLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: 14.0,
      fontWeight: medium,
    ),
    labelMedium: TextStyle(
      fontFamily: fontFamily,
      fontSize: 12.0,
      fontWeight: medium,
    ),
    labelSmall: TextStyle(
      fontFamily: fontFamily,
      fontSize: 10.0,
      fontWeight: regular,
    ),
  );

  // --- Named styles (responsive sizes from AppSizes) ---

  /// Dashboard greeting — Figma 35 Regular, LH 43.
  static TextStyle greeting(BuildContext context, {required double scale}) {
    final size = AppSizes.textGreeting(context) * scale;
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: size,
      fontWeight: regular,
      height: 43 / 35,
      color: AppColors.textPrimaryDark,
    );
  }

  static TextStyle searchHint(BuildContext context, {required double scale}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: AppSizes.textSearchHint(context) * scale,
      fontWeight: regular,
      letterSpacing: 0.015 * 17,
      color: AppColors.textSecondary,
    );
  }

  static TextStyle cardTitle(BuildContext context, {required double scale}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: AppSizes.textCardTitle(context) * scale,
      fontWeight: semiBold,
      color: AppColors.textPrimaryDark,
    );
  }

  static TextStyle metaLabel(BuildContext context, {required double scale}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: AppSizes.textMetaLabel(context) * scale,
      fontWeight: regular,
      color: AppColors.textSecondary,
    );
  }

  static TextStyle metaValue(BuildContext context, {required double scale}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: AppSizes.textMetaValue(context) * scale,
      fontWeight: medium,
      color: AppColors.textPrimaryDark,
    );
  }

  static TextStyle hotelName(BuildContext context, {required double scale}) {
    final size = AppSizes.textHotelName(context) * scale;
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: size,
      fontWeight: semiBold,
      height: 26 / 20,
      color: AppColors.textPrimaryDark,
    );
  }

  static TextStyle detailMeta(BuildContext context, {required double scale}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: AppSizes.textDetailMeta(context) * scale,
      fontWeight: regular,
      color: AppColors.textPrimaryDark,
    );
  }

  static TextStyle rating(BuildContext context, {required double scale}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: AppSizes.textDetailMeta(context) * scale,
      fontWeight: regular,
      color: AppColors.textPrimaryDark,
    );
  }

  static TextStyle address(BuildContext context, {required double scale}) {
    final size = AppSizes.textAddress(context) * scale;
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: size,
      fontWeight: regular,
      height: 22 / 16,
      color: AppColors.textSecondary,
    );
  }

  static TextStyle sectionTitle(BuildContext context, {required double scale}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: AppSizes.textSectionTitle(context) * scale,
      fontWeight: semiBold,
      color: AppColors.textPrimaryDark,
    );
  }

  static TextStyle description(BuildContext context, {required double scale}) {
    final size = AppSizes.textDescription(context) * scale;
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: size,
      fontWeight: regular,
      height: 24 / 16,
      color: AppColors.textMuted,
    );
  }

  /// Booking stay title — same size as greeting, Bold.
  static TextStyle bookingStayTitle(
    BuildContext context, {
    required double scale,
  }) {
    final size = AppSizes.textGreeting(context) * scale;
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: size,
      fontWeight: semiBold,
      height: 43 / 35,
      color: AppColors.textPrimaryDark,
    );
  }

  /// Booking date range subtitle — Figma ~16 Regular, secondary white.
  static TextStyle bookingDateRange(
    BuildContext context, {
    required double scale,
  }) {
    final size = AppSizes.textAddress(context) * scale;
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: size,
      fontWeight: regular,
      height: 22 / 16,
      color: AppColors.textSecondary,
    );
  }

  /// Booking cancel action — Figma Bold 18, #FF8000.
  static TextStyle bookingCancelDate(
    BuildContext context, {
    required double scale,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: AppSizes.textSectionTitle(context) * scale,
      fontWeight: bold,
      letterSpacing: 0.015 * 18,
      color: AppColors.cancelDate,
    );
  }

  /// Booking month label — Figma Medium 18 centered.
  static TextStyle bookingMonthLabel(
    BuildContext context, {
    required double scale,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: AppSizes.textSectionTitle(context) * scale,
      fontWeight: medium,
      color: AppColors.textPrimaryDark,
    );
  }

  /// Booking day cell — Figma Inter Regular 16 @ 80% white.
  static TextStyle bookingDayCell(
    BuildContext context, {
    required double scale,
  }) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: AppSizes.textMetaValue(context) * scale,
      fontWeight: regular,
      color: AppColors.textPrimaryDark.withValues(alpha: 0.8),
    );
  }

  /// SF Pro on Apple; falls back to system sans elsewhere.
  static const String sfProFamily = '.SF Pro Text';
  static const List<String> sfProFallback = [
    'SF Pro Text',
    'SFProText',
    'Helvetica Neue',
    'Roboto',
  ];

  /// Account menu title — Figma Nohemi SemiBold 15, tracking 1.5%.
  static TextStyle accountMenuTitle(
    BuildContext context, {
    required double scale,
  }) {
    final size = AppSizes.textAccountTitle(context) * scale;
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: size,
      fontWeight: semiBold,
      letterSpacing: 0.015 * 15,
      color: AppColors.textPrimaryDark,
    );
  }

  /// Account menu subtitle — Figma SF Pro Regular 12 @ 68% white.
  static TextStyle accountMenuSubtitle(
    BuildContext context, {
    required double scale,
  }) {
    final size = AppSizes.textAccountSubtitle(context) * scale;
    return TextStyle(
      fontFamily: sfProFamily,
      fontFamilyFallback: sfProFallback,
      fontSize: size,
      fontWeight: regular,
      color: AppColors.textSecondary,
    );
  }

  /// Subscription badge — Figma SF Pro Bold ~10, accent orange.
  static TextStyle accountComingSoonBadge(
    BuildContext context, {
    required double scale,
  }) {
    return TextStyle(
      fontFamily: sfProFamily,
      fontFamilyFallback: sfProFallback,
      fontSize: 10 * scale,
      fontWeight: bold,
      height: 16.55 / 9.93,
      color: AppColors.accentOrange,
    );
  }

  /// Side menu profile name — Figma Nohemi Medium 22.
  static TextStyle sideMenuProfileName(
    BuildContext context, {
    required double scale,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 18 * scale,
      fontWeight: medium,
      color: AppColors.textPrimaryDark,
      decoration: TextDecoration.none,
    );
  }

  /// Side menu location — Figma Nohemi Regular 14 @ 68% white.
  static TextStyle sideMenuProfileLocation(
    BuildContext context, {
    required double scale,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 14 * scale,
      fontWeight: regular,
      color: AppColors.textSecondary,
      decoration: TextDecoration.none,
    );
  }

  /// Side menu section label — Figma Nohemi SemiBold 15 @ 80% white.
  static TextStyle sideMenuSectionLabel(
    BuildContext context, {
    required double scale,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 15 * scale,
      fontWeight: semiBold,
      color: AppColors.textPrimaryDark.withValues(alpha: 0.8),
      decoration: TextDecoration.none,
    );
  }

  /// Side menu item label — Figma Nohemi Regular 18 @ 68% white.
  static TextStyle sideMenuItemLabel(
    BuildContext context, {
    required double scale,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 18 * scale,
      fontWeight: regular,
      color: AppColors.textSecondary,
      decoration: TextDecoration.none,
    );
  }

  /// Side menu notification badge — Figma SF Pro Regular, compact pill.
  static TextStyle sideMenuBadge(
    BuildContext context, {
    required double scale,
  }) {
    return TextStyle(
      fontFamily: sfProFamily,
      fontFamilyFallback: sfProFallback,
      fontSize: 12 * scale,
      fontWeight: regular,
      height: 1,
      color: AppColors.textPrimaryDark,
    );
  }
}
