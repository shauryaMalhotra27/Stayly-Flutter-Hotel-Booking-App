import 'package:flutter/material.dart';

import '../../../app/theme/app_sizes.dart';
import '../../../app/theme/app_typography.dart';
import '../../../core/utils/screen_scale.dart';

/// Precomputed layout numbers for the account screen.
class AccountMetrics {
  const AccountMetrics({
    required this.scale,
    required this.horizontalPadding,
    required this.navClearance,
    required this.headerTop,
    required this.rowHeight,
    required this.rowRadius,
    required this.rowGap,
    required this.rowHorizontalPadding,
    required this.rowTrailingPadding,
    required this.iconCircleSize,
    required this.iconSize,
    required this.chevronSize,
    required this.iconTextGap,
    required this.titleSubtitleGap,
    required this.badgeHeight,
    required this.badgeHorizontalPadding,
    required this.titleStyle,
    required this.subtitleStyle,
    required this.badgeStyle,
  });

  final double scale;
  final double horizontalPadding;
  final double navClearance;
  final double headerTop;
  final double rowHeight;
  final double rowRadius;
  final double rowGap;
  final double rowHorizontalPadding;
  final double rowTrailingPadding;
  final double iconCircleSize;
  final double iconSize;
  final double chevronSize;
  final double iconTextGap;
  final double titleSubtitleGap;
  final double badgeHeight;
  final double badgeHorizontalPadding;
  final TextStyle titleStyle;
  final TextStyle subtitleStyle;
  final TextStyle badgeStyle;

  factory AccountMetrics.of(BuildContext context) {
    final scale = ScreenScale.of(context);

    return AccountMetrics(
      scale: scale,
      horizontalPadding: AppSizes.marginHorizontal(context),
      navClearance: AppSizes.navClearance(context),
      // Align with dashboard / booking SafeArea + header spacing.
      headerTop: 24 * scale,
      // Figma row ~74 tall; radius = half height for a consistent stadium.
      rowHeight: 74 * scale,
      rowRadius: 37 * scale,
      // Figma vertical pitch 93 → gap ≈ 19.
      rowGap: 19 * scale,
      rowHorizontalPadding: 14 * scale,
      // Extra inset so the chevron sits inset from the pill edge (Figma).
      rowTrailingPadding: 26 * scale,
      iconCircleSize: 48 * scale,
      iconSize: 20 * scale,
      chevronSize: 12 * scale,
      iconTextGap: 10 * scale,
      titleSubtitleGap: 4 * scale,
      badgeHeight: 24 * scale,
      badgeHorizontalPadding: 12 * scale,
      titleStyle: AppTypography.accountMenuTitle(context, scale: scale),
      subtitleStyle: AppTypography.accountMenuSubtitle(context, scale: scale),
      badgeStyle: AppTypography.accountComingSoonBadge(context, scale: scale),
    );
  }
}
