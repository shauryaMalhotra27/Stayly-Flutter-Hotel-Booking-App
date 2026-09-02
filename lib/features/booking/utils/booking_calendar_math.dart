/// Date helpers for the booking calendar (Sunday-start grid, range formatting).
class BookingCalendarMath {
  BookingCalendarMath._();

  static const _weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  static const _months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  static DateTime dateOnly(DateTime value) =>
      DateTime(value.year, value.month, value.day);

  static bool isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  static int daysInMonth(int year, int month) =>
      DateTime(year, month + 1, 0).day;

  static int nightCount(DateTime start, DateTime end) =>
      dateOnly(end).difference(dateOnly(start)).inDays;

  static bool isInRange(DateTime day, DateTime start, DateTime end) {
    final d = dateOnly(day);
    final s = dateOnly(start);
    final e = dateOnly(end);
    return !d.isBefore(s) && !d.isAfter(e);
  }

  static String formatShortDate(DateTime date) {
    final weekday = _weekdays[date.weekday - 1];
    final month = _months[date.month - 1];
    return '$weekday, $month ${date.day}';
  }

  static String formatDateRange(DateTime start, DateTime end) =>
      '${formatShortDate(start)} – ${formatShortDate(end)}';

  static String formatMonthYear(DateTime month) =>
      '${_months[month.month - 1]} ${month.year}';
}

/// One cell in the month grid.
class CalendarCell {
  const CalendarCell({required this.date, required this.isCurrentMonth});

  final DateTime date;
  final bool isCurrentMonth;
}

/// Builds a Sunday-first month grid, padded only to complete weeks
/// (5 or 6 rows depending on the month — no forced extra week of next-month dates).
List<CalendarCell> buildMonthGrid(int year, int month) {
  final firstOfMonth = DateTime(year, month, 1);
  final daysInMonth = BookingCalendarMath.daysInMonth(year, month);
  final leading = firstOfMonth.weekday % 7;

  final prevMonth = month == 1 ? 12 : month - 1;
  final prevYear = month == 1 ? year - 1 : year;
  final prevDays = BookingCalendarMath.daysInMonth(prevYear, prevMonth);

  final cells = <CalendarCell>[];

  for (var i = leading - 1; i >= 0; i--) {
    cells.add(
      CalendarCell(
        date: DateTime(prevYear, prevMonth, prevDays - i),
        isCurrentMonth: false,
      ),
    );
  }

  for (var day = 1; day <= daysInMonth; day++) {
    cells.add(
      CalendarCell(date: DateTime(year, month, day), isCurrentMonth: true),
    );
  }

  var nextDay = 1;
  final nextMonth = month == 12 ? 1 : month + 1;
  final nextYear = month == 12 ? year + 1 : year;
  while (cells.length % 7 != 0) {
    cells.add(
      CalendarCell(
        date: DateTime(nextYear, nextMonth, nextDay++),
        isCurrentMonth: false,
      ),
    );
  }

  return cells;
}
