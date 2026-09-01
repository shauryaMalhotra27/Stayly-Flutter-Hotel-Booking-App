import 'package:flutter/material.dart';
import '../../core/utils/responsive_utils.dart';

/// Centralized design system sizes (padding, margins, icon sizes).
/// This ensures consistent scaling across the entire application based on the device screen size.
class AppSizes {
  AppSizes._();

  // --- MARGINS & PADDING ---

  /// Standard horizontal margin for the edges of the screen or major layout components.
  static double marginHorizontal(BuildContext context) => ResponsiveUtils.valueByDevice(
        context: context,
        smallMobile: 12.0,
        mediumMobile: 16.0,
        largeMobile: 24.0,
        tablet: 32.0,
      );

  /// Small padding, typically used for vertical padding inside buttons or cards.
  static double paddingSmall(BuildContext context) => ResponsiveUtils.valueByDevice(
        context: context,
        smallMobile: 10.0,
        mediumMobile: 12.0,
        largeMobile: 12.0,
        tablet: 14.0,
      );

  /// Medium padding, typically used for horizontal padding inside buttons or between larger elements.
  static double paddingMedium(BuildContext context) => ResponsiveUtils.valueByDevice(
        context: context,
        smallMobile: 10.0,
        mediumMobile: 14.0,
        largeMobile: 16.0,
        tablet: 20.0,
      );

  /// Compact horizontal padding for tight multi-item rows (e.g. bottom nav tabs).
  static double paddingCompact(BuildContext context) => ResponsiveUtils.valueByDevice(
        context: context,
        smallMobile: 8.0,
        mediumMobile: 10.0,
        largeMobile: 11.0,
        tablet: 12.0,
      );

  /// Small spacing/gap, typically used between an icon and its text.
  static double spacingSmall(BuildContext context) => ResponsiveUtils.valueByDevice(
        context: context,
        smallMobile: 4.0,
        mediumMobile: 6.0,
        largeMobile: 8.0,
        tablet: 8.0,
      );

  // --- ICONS ---

  /// Standard medium icon size.
  static double iconMedium(BuildContext context) => ResponsiveUtils.valueByDevice(
        context: context,
        smallMobile: 20.0,
        mediumMobile: 22.0,
        largeMobile: 24.0,
        tablet: 26.0,
      );

  // --- TEXT SIZES ---

  /// Small text size, typically used for navigation labels or secondary captions.
  static double textSmall(BuildContext context) => ResponsiveUtils.valueByDevice(
        context: context,
        smallMobile: 12.0,
        mediumMobile: 14.0,
        largeMobile: 15.0,
        tablet: 16.0,
      );
}

