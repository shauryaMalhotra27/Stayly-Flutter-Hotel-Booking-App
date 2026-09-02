import 'package:flutter/material.dart';

import '../../../app/theme/app_sizes.dart';
import '../../../app/theme/app_typography.dart';
import '../../../core/utils/screen_scale.dart';

/// Precomputed layout numbers for the booking screen.
class BookingMetrics {
  const BookingMetrics({
    required this.scale,
    required this.horizontalPadding,
    required this.cardRadius,
    required this.navClearance,
    required this.stayTitleStyle,
    required this.dateRangeStyle,
    required this.cancelDateStyle,
    required this.monthLabelStyle,
    required this.dayCellStyle,
    required this.calendarHorizontalPadding,
    required this.calendarVerticalPadding,
    required this.calendarBottomPadding,
    required this.monthLabelGap,
    required this.dayCellHeight,
    required this.dayCellRadius,
    required this.dayRowGap,
    required this.monthNavSize,
    required this.monthNavGap,
    required this.headerTop,
    required this.calendarTopGap,
    required this.monthNavTopGap,
  });

  final double scale;
  final double horizontalPadding;
  final double cardRadius;
  final double navClearance;
  final TextStyle stayTitleStyle;
  final TextStyle dateRangeStyle;
  final TextStyle cancelDateStyle;
  final TextStyle monthLabelStyle;
  final TextStyle dayCellStyle;
  final double calendarHorizontalPadding;
  final double calendarVerticalPadding;
  final double calendarBottomPadding;
  final double monthLabelGap;
  final double dayCellHeight;
  final double dayCellRadius;
  final double dayRowGap;
  final double monthNavSize;
  final double monthNavGap;
  final double headerTop;
  final double calendarTopGap;
  final double monthNavTopGap;

  factory BookingMetrics.of(BuildContext context) {
    final scale = ScreenScale.of(context);
    final horizontal = AppSizes.marginHorizontal(context);

    return BookingMetrics(
      scale: scale,
      horizontalPadding: horizontal,
      cardRadius: AppSizes.cardRadius(context),
      navClearance: AppSizes.navClearance(context),
      stayTitleStyle: AppTypography.bookingStayTitle(context, scale: scale),
      dateRangeStyle: AppTypography.bookingDateRange(context, scale: scale),
      cancelDateStyle: AppTypography.bookingCancelDate(context, scale: scale),
      monthLabelStyle: AppTypography.bookingMonthLabel(context, scale: scale),
      dayCellStyle: AppTypography.bookingDayCell(context, scale: scale),
      calendarHorizontalPadding: 16 * scale,
      calendarVerticalPadding: 20 * scale,
      calendarBottomPadding: 16 * scale,
      monthLabelGap: 16 * scale,
      dayCellHeight: 40 * scale,
      dayCellRadius: 8 * scale,
      dayRowGap: 6 * scale,
      // Slightly smaller than before to match Figma arrow discs.
      monthNavSize: 32 * scale,
      monthNavGap: 56 * scale,
      // Match dashboard: SafeArea + 24*scale above greeting.
      headerTop: 24 * scale,
      calendarTopGap: 24 * scale,
      monthNavTopGap: 20 * scale,
    );
  }
}
