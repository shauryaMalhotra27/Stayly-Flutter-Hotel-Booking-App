import 'package:flutter/material.dart';

import '../../../app/theme/app_icons.dart';
import '../../../core/widgets/circle_icon_button.dart';
import '../utils/booking_metrics.dart';

class BookingMonthNav extends StatelessWidget {
  const BookingMonthNav({
    super.key,
    required this.metrics,
    required this.onPrevious,
    required this.onNext,
  });

  final BookingMetrics metrics;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleIconButton(
          size: metrics.monthNavSize,
          iconPath: AppIcons.leftArrow,
          onTap: onPrevious,
        ),
        SizedBox(width: metrics.monthNavGap),
        CircleIconButton(
          size: metrics.monthNavSize,
          iconPath: AppIcons.rightArrow,
          onTap: onNext,
        ),
      ],
    );
  }
}
