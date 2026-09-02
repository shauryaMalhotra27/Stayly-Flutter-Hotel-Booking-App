import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../l10n/app_strings.dart';
import '../utils/booking_calendar_math.dart';
import '../utils/booking_metrics.dart';

class BookingStayHeader extends StatelessWidget {
  const BookingStayHeader({
    super.key,
    required this.metrics,
    required this.rangeStart,
    required this.rangeEnd,
    required this.onCancelDate,
  });

  final BookingMetrics metrics;
  final DateTime? rangeStart;
  final DateTime? rangeEnd;
  final VoidCallback onCancelDate;

  bool get _hasCompleteRange =>
      rangeStart != null &&
      rangeEnd != null &&
      !BookingCalendarMath.isSameDay(rangeStart!, rangeEnd!);

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.current;

    final title = _hasCompleteRange
        ? s.nightStay(BookingCalendarMath.nightCount(rangeStart!, rangeEnd!))
        : s.selectDatesHint;

    final subtitle = _hasCompleteRange
        ? BookingCalendarMath.formatDateRange(rangeStart!, rangeEnd!)
        : null;

    // Fixed subtitle slot so selecting a range never shifts the calendar.
    final subtitleStyle = metrics.dateRangeStyle;
    final subtitleLineHeight =
        (subtitleStyle.fontSize ?? 16) * (subtitleStyle.height ?? 1.375);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: metrics.stayTitleStyle),
              SizedBox(height: 6 * metrics.scale),
              SizedBox(
                height: subtitleLineHeight,
                child: subtitle == null
                    ? null
                    : Text(
                        subtitle,
                        style: subtitleStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
              ),
            ],
          ),
        ),
        SizedBox(width: 12 * metrics.scale),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onCancelDate,
            borderRadius: BorderRadius.circular(4),
            child: Padding(
              padding: EdgeInsets.only(
                top: 6 * metrics.scale,
                left: 4 * metrics.scale,
                right: 4 * metrics.scale,
                bottom: 4 * metrics.scale,
              ),
              child: Text(
                s.cancelDate,
                style: metrics.cancelDateStyle.copyWith(
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.cancelDateUnderline,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
