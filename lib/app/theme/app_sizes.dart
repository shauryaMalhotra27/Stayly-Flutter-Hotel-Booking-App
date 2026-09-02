import 'package:flutter/material.dart';
import '../../core/utils/responsive_utils.dart';

/// Design-system sizes. Tier values follow Figma (~390–440) as medium/large.
class AppSizes {
  AppSizes._();

  // --- MARGINS & PADDING ---

  static double marginHorizontal(BuildContext context) =>
      ResponsiveUtils.valueByDevice(
        context: context,
        smallMobile: 16.0,
        mediumMobile: 20.0,
        largeMobile: 23.0,
        tablet: 32.0,
      );

  static double paddingSmall(BuildContext context) =>
      ResponsiveUtils.valueByDevice(
        context: context,
        smallMobile: 10.0,
        mediumMobile: 12.0,
        largeMobile: 12.0,
        tablet: 14.0,
      );

  static double paddingMedium(BuildContext context) =>
      ResponsiveUtils.valueByDevice(
        context: context,
        smallMobile: 10.0,
        mediumMobile: 14.0,
        largeMobile: 16.0,
        tablet: 20.0,
      );

  static double paddingCompact(BuildContext context) =>
      ResponsiveUtils.valueByDevice(
        context: context,
        smallMobile: 8.0,
        mediumMobile: 10.0,
        largeMobile: 11.0,
        tablet: 12.0,
      );

  static double spacingSmall(BuildContext context) =>
      ResponsiveUtils.valueByDevice(
        context: context,
        smallMobile: 4.0,
        mediumMobile: 6.0,
        largeMobile: 8.0,
        tablet: 8.0,
      );

  /// Gap between property cards (Figma: 24).
  static double cardGap(BuildContext context) => ResponsiveUtils.valueByDevice(
    context: context,
    smallMobile: 18.0,
    mediumMobile: 22.0,
    largeMobile: 24.0,
    tablet: 28.0,
  );

  /// Content inset for hotel detail (Figma: ~29).
  static double detailHorizontal(BuildContext context) =>
      ResponsiveUtils.valueByDevice(
        context: context,
        smallMobile: 20.0,
        mediumMobile: 24.0,
        largeMobile: 29.0,
        tablet: 36.0,
      );

  // --- LAYOUT ---

  static double searchBarHeight(BuildContext context) =>
      ResponsiveUtils.valueByDevice(
        context: context,
        smallMobile: 56.0,
        mediumMobile: 62.0,
        largeMobile: 66.0,
        tablet: 72.0,
      );

  static double menuButtonSize(BuildContext context) =>
      ResponsiveUtils.valueByDevice(
        context: context,
        smallMobile: 52.0,
        mediumMobile: 60.0,
        largeMobile: 69.0,
        tablet: 72.0,
      );

  static double cardRadius(BuildContext context) =>
      ResponsiveUtils.valueByDevice(
        context: context,
        smallMobile: 32.0,
        mediumMobile: 36.0,
        largeMobile: 40.0,
        tablet: 44.0,
      );

  static double searchRadius(BuildContext context) =>
      ResponsiveUtils.valueByDevice(
        context: context,
        smallMobile: 40.0,
        mediumMobile: 46.0,
        largeMobile: 50.0,
        tablet: 54.0,
      );

  /// Bottom clearance so scroll content clears the floating nav.
  static double navClearance(BuildContext context) =>
      ResponsiveUtils.valueByDevice(
        context: context,
        smallMobile: 100.0,
        mediumMobile: 110.0,
        largeMobile: 120.0,
        tablet: 130.0,
      );

  // --- ICONS ---

  /// Nav icons — Figma 24×24 at largeMobile, scales by device tier.
  static double navIcon(BuildContext context) => ResponsiveUtils.valueByDevice(
    context: context,
    smallMobile: 20.0,
    mediumMobile: 22.0,
    largeMobile: 24.0,
    tablet: 26.0,
  );

  static double iconMedium(BuildContext context) =>
      ResponsiveUtils.valueByDevice(
        context: context,
        smallMobile: 20.0,
        mediumMobile: 22.0,
        largeMobile: 24.0,
        tablet: 26.0,
      );

  // --- TEXT SIZES (Figma baselines at largeMobile) ---

  static double textSmall(BuildContext context) =>
      ResponsiveUtils.valueByDevice(
        context: context,
        smallMobile: 12.0,
        mediumMobile: 14.0,
        largeMobile: 15.0,
        tablet: 16.0,
      );

  static double textGreeting(BuildContext context) =>
      ResponsiveUtils.valueByDevice(
        context: context,
        smallMobile: 28.0,
        mediumMobile: 32.0,
        largeMobile: 35.0,
        tablet: 40.0,
      );

  static double textCardTitle(BuildContext context) =>
      ResponsiveUtils.valueByDevice(
        context: context,
        smallMobile: 18.0,
        mediumMobile: 20.0,
        largeMobile: 22.0,
        tablet: 24.0,
      );

  static double textSearchHint(BuildContext context) =>
      ResponsiveUtils.valueByDevice(
        context: context,
        smallMobile: 14.0,
        mediumMobile: 16.0,
        largeMobile: 17.0,
        tablet: 18.0,
      );

  static double textMetaLabel(BuildContext context) =>
      ResponsiveUtils.valueByDevice(
        context: context,
        smallMobile: 11.0,
        mediumMobile: 12.0,
        largeMobile: 13.0,
        tablet: 14.0,
      );

  static double textMetaValue(BuildContext context) =>
      ResponsiveUtils.valueByDevice(
        context: context,
        smallMobile: 14.0,
        mediumMobile: 15.0,
        largeMobile: 16.0,
        tablet: 17.0,
      );

  static double textHotelName(BuildContext context) =>
      ResponsiveUtils.valueByDevice(
        context: context,
        smallMobile: 17.0,
        mediumMobile: 18.0,
        largeMobile: 20.0,
        tablet: 22.0,
      );

  static double textDetailMeta(BuildContext context) =>
      ResponsiveUtils.valueByDevice(
        context: context,
        smallMobile: 13.0,
        mediumMobile: 14.0,
        largeMobile: 15.0,
        tablet: 16.0,
      );

  static double textAddress(BuildContext context) =>
      ResponsiveUtils.valueByDevice(
        context: context,
        smallMobile: 14.0,
        mediumMobile: 15.0,
        largeMobile: 16.0,
        tablet: 17.0,
      );

  static double textSectionTitle(BuildContext context) =>
      ResponsiveUtils.valueByDevice(
        context: context,
        smallMobile: 16.0,
        mediumMobile: 17.0,
        largeMobile: 18.0,
        tablet: 20.0,
      );

  static double textDescription(BuildContext context) =>
      ResponsiveUtils.valueByDevice(
        context: context,
        smallMobile: 14.0,
        mediumMobile: 15.0,
        largeMobile: 16.0,
        tablet: 17.0,
      );
}
