import 'package:flutter/material.dart';

import '../../../app/theme/app_typography.dart';
import '../../../core/utils/screen_scale.dart';

/// Side menu layout metrics.
class SideMenuMetrics {
  const SideMenuMetrics({
    required this.scale,
    required this.horizontalPadding,
    required this.topPadding,
    required this.avatarSize,
    required this.closeSize,
    required this.iconCircleSize,
    required this.iconSize,
    required this.chevronSize,
    required this.itemGap,
    required this.sectionGap,
    required this.sectionLabelGap,
    required this.itemVerticalPadding,
    required this.itemHorizontalPadding,
    required this.itemTrailingInset,
    required this.itemBorderRadius,
    required this.badgeMinWidth,
    required this.badgeHeight,
    required this.badgeHorizontalPadding,
    required this.profileNameStyle,
    required this.profileLocationStyle,
    required this.sectionLabelStyle,
    required this.itemLabelStyle,
    required this.badgeStyle,
  });

  final double scale;
  final double horizontalPadding;
  final double topPadding;
  final double avatarSize;
  final double closeSize;
  final double iconCircleSize;
  final double iconSize;
  final double chevronSize;
  final double itemGap;
  final double sectionGap;
  final double sectionLabelGap;
  final double itemVerticalPadding;
  final double itemHorizontalPadding;

  /// Inset so chevrons sit left of the close button.
  final double itemTrailingInset;
  final double itemBorderRadius;
  final double badgeMinWidth;
  final double badgeHeight;
  final double badgeHorizontalPadding;
  final TextStyle profileNameStyle;
  final TextStyle profileLocationStyle;
  final TextStyle sectionLabelStyle;
  final TextStyle itemLabelStyle;
  final TextStyle badgeStyle;

  factory SideMenuMetrics.of(BuildContext context) {
    final scale = ScreenScale.of(context);

    return SideMenuMetrics(
      scale: scale,
      horizontalPadding: 20 * scale,
      topPadding: 12 * scale,
      avatarSize: 48 * scale,
      closeSize: 14 * scale,
      iconCircleSize: 46 * scale,
      iconSize: 28 * scale,
      chevronSize: 12 * scale,
      itemGap: 2 * scale,
      sectionGap: 16 * scale,
      sectionLabelGap: 8 * scale,
      itemVerticalPadding: 6 * scale,
      itemHorizontalPadding: 17 * scale,
      itemTrailingInset: 36 * scale,
      itemBorderRadius: 80 * scale,
      badgeMinWidth: 28 * scale,
      badgeHeight: 20 * scale,
      badgeHorizontalPadding: 8 * scale,
      profileNameStyle: AppTypography.sideMenuProfileName(
        context,
        scale: scale,
      ),
      profileLocationStyle: AppTypography.sideMenuProfileLocation(
        context,
        scale: scale,
      ),
      sectionLabelStyle: AppTypography.sideMenuSectionLabel(
        context,
        scale: scale,
      ),
      itemLabelStyle: AppTypography.sideMenuItemLabel(context, scale: scale),
      badgeStyle: AppTypography.sideMenuBadge(context, scale: scale),
    );
  }
}
