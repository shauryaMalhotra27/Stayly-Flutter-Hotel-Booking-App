import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/widgets/surface_card.dart';
import '../utils/booking_calendar_math.dart';
import '../utils/booking_metrics.dart';

class BookingCalendarCard extends StatelessWidget {
  const BookingCalendarCard({
    super.key,
    required this.metrics,
    required this.focusedMonth,
    required this.rangeStart,
    required this.rangeEnd,
    required this.onDaySelected,
  });

  final BookingMetrics metrics;
  final DateTime focusedMonth;
  final DateTime? rangeStart;
  final DateTime? rangeEnd;
  final ValueChanged<DateTime> onDaySelected;

  @override
  Widget build(BuildContext context) {
    final cells = buildMonthGrid(focusedMonth.year, focusedMonth.month);
    final monthLabel = BookingCalendarMath.formatMonthYear(focusedMonth);
    final rowCount = cells.length ~/ 7;
    // Reserve empty space for a 6th week when the month only needs 5 rows.
    const maxRows = 6;
    final reservedRows = maxRows - rowCount;
    final radius = BorderRadius.circular(metrics.cardRadius);

    return SurfaceCard(
      borderRadius: radius,
      padding: EdgeInsets.fromLTRB(
        metrics.calendarHorizontalPadding,
        metrics.calendarVerticalPadding,
        metrics.calendarHorizontalPadding,
        metrics.calendarBottomPadding,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(monthLabel, style: metrics.monthLabelStyle),
          SizedBox(height: metrics.monthLabelGap),
          for (var row = 0; row < rowCount; row++) ...[
            if (row > 0) SizedBox(height: metrics.dayRowGap),
            Row(
              children: [
                for (var col = 0; col < 7; col++)
                  Expanded(
                    child: _DayCell(
                      metrics: metrics,
                      date: cells[row * 7 + col].date,
                      isCurrentMonth: cells[row * 7 + col].isCurrentMonth,
                      rangeStart: rangeStart,
                      rangeEnd: rangeEnd,
                      onTap: () => onDaySelected(cells[row * 7 + col].date),
                    ),
                  ),
              ],
            ),
          ],
          if (reservedRows > 0)
            SizedBox(
              height:
                  reservedRows * (metrics.dayCellHeight + metrics.dayRowGap),
            ),
        ],
      ),
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.metrics,
    required this.date,
    required this.isCurrentMonth,
    required this.rangeStart,
    required this.rangeEnd,
    required this.onTap,
  });

  final BookingMetrics metrics;
  final DateTime date;
  final bool isCurrentMonth;
  final DateTime? rangeStart;
  final DateTime? rangeEnd;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final start = rangeStart;
    final end = rangeEnd;
    final hasRange = start != null && end != null;
    final isStart = start != null && BookingCalendarMath.isSameDay(date, start);
    final isEnd = end != null && BookingCalendarMath.isSameDay(date, end);
    final isSingleDay =
        hasRange && BookingCalendarMath.isSameDay(start, end) && isStart;
    final inRange =
        hasRange &&
        !BookingCalendarMath.isSameDay(start, end) &&
        BookingCalendarMath.isInRange(date, start, end);
    final isEndpoint = isStart || isEnd;
    final isMiddle = inRange && !isEndpoint;

    Color? background;
    BorderRadius? radius;

    if (isSingleDay) {
      background = AppColors.primary;
      radius = BorderRadius.circular(metrics.dayCellRadius);
    } else if (isStart) {
      background = AppColors.primary;
      radius = BorderRadius.horizontal(
        left: Radius.circular(metrics.dayCellRadius),
        right: Radius.zero,
      );
    } else if (isEnd) {
      background = AppColors.primary;
      radius = BorderRadius.horizontal(
        left: Radius.zero,
        right: Radius.circular(metrics.dayCellRadius),
      );
    } else if (isMiddle) {
      background = AppColors.primary.withValues(alpha: 0.35);
      radius = BorderRadius.zero;
    }

    final textColor = isEndpoint || isSingleDay
        ? AppColors.textPrimaryDark
        : isCurrentMonth
        ? AppColors.textPrimaryDark.withValues(alpha: 0.8)
        : AppColors.textMuted;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius ?? BorderRadius.circular(metrics.dayCellRadius),
        child: SizedBox(
          height: metrics.dayCellHeight,
          child: DecoratedBox(
            decoration: background != null
                ? BoxDecoration(color: background, borderRadius: radius)
                : const BoxDecoration(),
            child: Center(
              child: Text(
                '${date.day}',
                style: metrics.dayCellStyle.copyWith(color: textColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
