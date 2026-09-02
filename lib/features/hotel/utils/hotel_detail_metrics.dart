import 'package:flutter/material.dart';
import '../../../app/theme/app_sizes.dart';
import '../../../app/theme/app_typography.dart';
import '../../../core/utils/screen_scale.dart';

/// Precomputed layout numbers for the hotel detail screen.
class HotelDetailMetrics {
  const HotelDetailMetrics({
    required this.scale,
    required this.horizontalPadding,
    required this.cardRadius,
    required this.heroHeight,
    required this.panelOverlap,
    required this.hostAvatarSize,
    required this.starSize,
    required this.bellSize,
    required this.navClearance,
    required this.hotelNameStyle,
    required this.detailMetaStyle,
    required this.ratingStyle,
    required this.addressStyle,
    required this.sectionTitleStyle,
    required this.descriptionStyle,
  });

  final double scale;
  final double horizontalPadding;
  final double cardRadius;
  final double heroHeight;
  final double panelOverlap;
  final double hostAvatarSize;
  final double starSize;
  final double bellSize;
  final double navClearance;
  final TextStyle hotelNameStyle;
  final TextStyle detailMetaStyle;
  final TextStyle ratingStyle;
  final TextStyle addressStyle;
  final TextStyle sectionTitleStyle;
  final TextStyle descriptionStyle;

  factory HotelDetailMetrics.of(BuildContext context) {
    final scale = ScreenScale.of(context);
    final width = MediaQuery.sizeOf(context).width;
    // Same 0×0 first-frame as the dashboard: keep heroHeight - panelOverlap >= 0.
    final heroHeight = (width * (374 / 440)).clamp(0.0, double.infinity);
    final panelOverlap = (80 * scale).clamp(0.0, heroHeight);

    return HotelDetailMetrics(
      scale: scale,
      horizontalPadding: AppSizes.detailHorizontal(context),
      cardRadius: AppSizes.cardRadius(context),
      // Figma hero ~374 on ~440 width.
      heroHeight: heroHeight,
      panelOverlap: panelOverlap,
      hostAvatarSize: 76 * scale,
      starSize: 22 * scale,
      // Visible blue disc ~36; SVG has its own padding so glyph can fill more.
      bellSize: 36 * scale,
      navClearance: AppSizes.navClearance(context),
      hotelNameStyle: AppTypography.hotelName(context, scale: scale),
      detailMetaStyle: AppTypography.detailMeta(context, scale: scale),
      ratingStyle: AppTypography.rating(context, scale: scale),
      addressStyle: AppTypography.address(context, scale: scale),
      sectionTitleStyle: AppTypography.sectionTitle(context, scale: scale),
      descriptionStyle: AppTypography.description(context, scale: scale),
    );
  }
}
