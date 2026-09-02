import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_icons.dart';
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
        _NavCircleButton(
          size: metrics.monthNavSize,
          icon: AppIcons.leftArrow,
          onTap: onPrevious,
        ),
        SizedBox(width: metrics.monthNavGap),
        _NavCircleButton(
          size: metrics.monthNavSize,
          icon: AppIcons.rightArrow,
          onTap: onNext,
        ),
      ],
    );
  }
}

class _NavCircleButton extends StatelessWidget {
  const _NavCircleButton({
    required this.size,
    required this.icon,
    required this.onTap,
  });

  final double size;
  final String icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primary,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: size,
          height: size,
          child: Center(
            child: SvgPicture.asset(
              icon,
              width: size * 0.45,
              height: size * 0.45,
              colorFilter: const ColorFilter.mode(
                AppColors.textPrimaryDark,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
