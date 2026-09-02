import 'package:flutter/material.dart';
import '../../../app/theme/app_sizes.dart';
import '../../../app/theme/app_typography.dart';
import '../../../core/utils/screen_scale.dart';

/// Precomputed layout numbers for the dashboard (same pattern as nav metrics).
class DashboardMetrics {
  const DashboardMetrics({
    required this.scale,
    required this.horizontalPadding,
    required this.cardGap,
    required this.searchHeight,
    required this.searchRadius,
    required this.menuSize,
    required this.cardRadius,
    required this.iconSize,
    required this.navClearance,
    required this.greetingStyle,
    required this.searchHintStyle,
    required this.cardTitleStyle,
    required this.metaLabelStyle,
    required this.metaValueStyle,
    required this.imageHeight,
    required this.metaPanelHeight,
    required this.headerTop,
    required this.searchTopGap,
    required this.listTopGap,
  });

  final double scale;
  final double horizontalPadding;
  final double cardGap;
  final double searchHeight;
  final double searchRadius;
  final double menuSize;
  final double cardRadius;
  final double iconSize;
  final double navClearance;
  final TextStyle greetingStyle;
  final TextStyle searchHintStyle;
  final TextStyle cardTitleStyle;
  final TextStyle metaLabelStyle;
  final TextStyle metaValueStyle;
  final double imageHeight;
  final double metaPanelHeight;
  final double headerTop;
  final double searchTopGap;
  final double listTopGap;

  factory DashboardMetrics.of(BuildContext context) {
    final scale = ScreenScale.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final horizontal = AppSizes.marginHorizontal(context);
    // Android can report 0×0 before the Flutter surface attaches. Subtracting
    // padding from that width made image/meta heights negative and crashed
    // PropertyCard (BoxConstraints h=-29.6).
    final cardWidth = (width - 2 * horizontal).clamp(0.0, double.infinity);

    return DashboardMetrics(
      scale: scale,
      horizontalPadding: horizontal,
      cardGap: AppSizes.cardGap(context),
      searchHeight: AppSizes.searchBarHeight(context) * scale,
      searchRadius: AppSizes.searchRadius(context),
      menuSize: AppSizes.menuButtonSize(context) * scale,
      cardRadius: AppSizes.cardRadius(context),
      iconSize: AppSizes.iconMedium(context) * scale,
      navClearance: AppSizes.navClearance(context),
      greetingStyle: AppTypography.greeting(context, scale: scale),
      searchHintStyle: AppTypography.searchHint(context, scale: scale),
      cardTitleStyle: AppTypography.cardTitle(context, scale: scale),
      metaLabelStyle: AppTypography.metaLabel(context, scale: scale),
      metaValueStyle: AppTypography.metaValue(context, scale: scale),
      // Figma image ~278 on ~393 width.
      imageHeight: cardWidth * (278 / 393),
      metaPanelHeight: cardWidth * (157 / 396),
      headerTop: 24 * scale,
      searchTopGap: 24 * scale,
      listTopGap: 28 * scale,
    );
  }
}
