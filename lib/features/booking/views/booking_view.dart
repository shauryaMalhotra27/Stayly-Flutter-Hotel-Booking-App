import 'package:flutter/material.dart';

import '../../../core/widgets/app_background.dart';
import '../utils/booking_calendar_math.dart';
import '../utils/booking_metrics.dart';
import '../widgets/booking_calendar_card.dart';
import '../widgets/booking_month_nav.dart';
import '../widgets/booking_stay_header.dart';

class BookingView extends StatefulWidget {
  const BookingView({super.key});

  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
  static final _demoStart = DateTime(2026, 10, 24);
  static final _demoEnd = DateTime(2026, 10, 26);

  DateTime? _rangeStart = _demoStart;
  DateTime? _rangeEnd = _demoEnd;
  late DateTime _focusedMonth = DateTime(_demoStart.year, _demoStart.month);

  void _onDaySelected(DateTime day) {
    final date = BookingCalendarMath.dateOnly(day);
    setState(() {
      if (_rangeStart == null || _rangeEnd != null) {
        _rangeStart = date;
        _rangeEnd = null;
        return;
      }

      if (date.isBefore(_rangeStart!)) {
        _rangeEnd = _rangeStart;
        _rangeStart = date;
      } else {
        _rangeEnd = date;
      }
    });
  }

  void _onCancelDate() {
    setState(() {
      _rangeStart = null;
      _rangeEnd = null;
    });
  }

  void _onPreviousMonth() {
    setState(() {
      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month - 1);
    });
  }

  void _onNextMonth() {
    setState(() {
      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final m = BookingMetrics.of(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBackground(
        // Same top inset pattern as Dashboard: SafeArea + headerTop.
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              m.horizontalPadding,
              m.headerTop,
              m.horizontalPadding,
              m.navClearance,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BookingStayHeader(
                  metrics: m,
                  rangeStart: _rangeStart,
                  rangeEnd: _rangeEnd,
                  onCancelDate: _onCancelDate,
                ),
                // Calendar + month arrows vertically centered in remaining space.
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BookingCalendarCard(
                        metrics: m,
                        focusedMonth: _focusedMonth,
                        rangeStart: _rangeStart,
                        rangeEnd: _rangeEnd,
                        onDaySelected: _onDaySelected,
                      ),
                      SizedBox(height: m.monthNavTopGap),
                      BookingMonthNav(
                        metrics: m,
                        onPrevious: _onPreviousMonth,
                        onNext: _onNextMonth,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
